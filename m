Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9851C52C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbiEEQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEEQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:35:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89055C756
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:31:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245GLHMF013502;
        Thu, 5 May 2022 16:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0g9azotTZRUuAHoCBQ/N1Gf4mjwvuDOh0gGSNIGZy8U=;
 b=vQAyudKqU7RaAgdkgudRcaiUT9ig3i2/AZKKISYe84vBSwdszqUqjZcWvTMCDYa26AMT
 2do0ZzTYn0YHe6oGYg8mYxkpjnLPRNyQ3Z6BtLvI71Usjyswau+WgAc/prphcWKcTZKi
 XRer2m7B95hjnARjBY/rlw/CFRZodtEVMhMQBwlStELyTZr9RmKKh8VUBiUpY9F0fge9
 oVBq9cAaEdYhlvvrfi3k/4PSTE0eQ5RlXvWJrhkunnNxgHvoIWcyPdf2GQ2RmzK7nCq6
 4NBROKp9d6BUFQWxqtl6Q0B+OjJfrZedDA7MU2f9PQ229EmyqkmiYqOfH8KqAZyZ9D/E rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqskx5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 16:31:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245GGsfg003781;
        Thu, 5 May 2022 16:31:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj4w4ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 16:31:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTJ5/TI435QZtKcW267EJqe8JsrejQ23sxKIA61biIuIyhr2YLuwSMnPUH629lP0GMOrTDOHGCBONQG/e32IO7g01SDwEYbwlSJALmqfp/ORS+LoUEtL3CtwXLbcPzRVYR5y9iaEOhBhax+hz1RcStaxRRxQpkhuhySVdmVIasfwtvpAg285Rq8NaGfVfELmJqT2Rw0HTSfAS1diLS8YTrAUU3mjaNG7Eqaw7rH7CwKPI+eao5wIt11NW/JMLwm5tXATriMilnQFjsVtCLsdCr2AbptA/K1s4QKq1MhOu6MfoTJDDRD/+MqP1CaTU29ILw9Y4qtnMEPXSzAIvedwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g9azotTZRUuAHoCBQ/N1Gf4mjwvuDOh0gGSNIGZy8U=;
 b=ZjAipDFRKdjm/LwGNVRCoNgyr6m+AAZGI3DL+VnonWXe7aQmVrK7Kf7p4DDquG0Ja+HDg5OHzHPSf8hhyAsbzTGFxeK6mnEy9iGy8s0A+wega0VeIvgY7g6H0CWgYLkQhtVJYfCG1nHpU76E+y0YL/4SLTYgyBe2GU7gPDOjb+HD9LY6y9VCxoFAayGeQPoEXoEz3rV/wdkp2o8gi6jIHkAJZSZXJYV6AeeNtX6VYIZj3UuzT8iqlm9jNxb/C7Mpr0EAvrxV6GWUpNciEGRclE6E/22maJO4i/E5TGPyPTOgOg3QDZ23P+fBYJZvqBRFTv9jKUirJzNjVH2ISSB2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g9azotTZRUuAHoCBQ/N1Gf4mjwvuDOh0gGSNIGZy8U=;
 b=VJDcnTqR6JThO1nv45IDVM53wAtfgUReR6xEmifBM88utZftPxbnL5RVZaxraL1rj8qArWAD9vhQUXvcnGSUK5YigbcKq9JvOWIZd9/oDCDW7jLdwhjdf+Vqw2gC6Hafoxx0zTKpa+tEuqnjPPPF0IVKKMrnBoDnWtNeI2T4BCg=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MWHPR10MB1533.namprd10.prod.outlook.com (2603:10b6:300:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 16:31:12 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 16:31:12 +0000
Message-ID: <f384f515-cab6-042d-5ba8-cef5d615b991@oracle.com>
Date:   Thu, 5 May 2022 11:31:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <d90f4299-e821-f5d5-957a-1e84f16816e0@linux.ibm.com>
 <300a485c-4bc5-c58a-d34a-bacdb1fa4510@oracle.com>
 <100fa9f0-fc24-7a3f-33c6-3d4e7f6f4a93@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <100fa9f0-fc24-7a3f-33c6-3d4e7f6f4a93@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6ecdca1-23b9-446c-a4e0-08da2eb4aad4
X-MS-TrafficTypeDiagnostic: MWHPR10MB1533:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB153324B8DD416B2FC7D64BD897C29@MWHPR10MB1533.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3WIZ7Zpu3y/fWC1gu1T9mrUuG4cMd/QFa1q5p7Lrj84HDIRucdMkjK4TtK1Ryuaaw6fYKXOjRZuujjIssXqoHitrCmaAP/jkycyFwQRajjgI7XUsvMdtfXsDplB9spnMGp5dm/tLbIsRsA+MGGU/mKWG0oEL2eUUvNhPtgWNN3GQp41lQHczGlGwiMC7sNF+gZqsf/YiDW0bS8FDHwqlRZUVtFPCwpGBS2lAPN9JoyOqtDS+3neUjgt5bb+dUXn3MawRXyzhOsMKnFawee49pOzIA6PYUShFi3144VX7lWwEpu5ewNIhbPxlCfify2tzFZYlyg0Ww3duOHY8xKZN62HcSv3aYfHxzrIIZeZ2Oa1QAeC/0BxfLr4mxhaU21dJ7lB/Xw3tfFlT0SLFh3f7gn2cDFITh8pLwFzRfZoaSK8iA+oruWIRLPPaJikWY4qUJbu7p6VBONRGSV5lfLcCWeYCXD25k9BAv30I76rXlokpLvCwey3jflb13gggrntfdJ3Rn/pFPNare4PpBVZKr+jIxNZoF5Kj54IN1MdMm5rN3+Jy4nePCgtsFmqQCeLzUq6vNZxRhkDPLiWbgBYyhPguW3pbPDL02Z6WjEUXeWoXZchEibJ/h2ncgjJFCz0H0TNgrtWa4n1Ej4Tea8XpMyNYmSQuybkDgiAC+wc0xc1mVszHDqqyvPWYhNHaJ1sknSs6I/GYktPJ/vLAB5N46yZnrZE+nzqRlJ2rjLp7TY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66946007)(4326008)(66556008)(66476007)(8676002)(2616005)(31696002)(86362001)(2906002)(8936002)(7416002)(5660300002)(508600001)(6486002)(36756003)(31686004)(107886003)(186003)(6666004)(6506007)(6512007)(53546011)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlPbXVtc3RMd1lGUUJ5d3d4RXZNUlJHWTJsMWo3djZnRXJ1Sk5mTDdQTWwv?=
 =?utf-8?B?a3FvUCtKZVBVS0hkREt2KzUrSzc4MUQ1VG1QTGRhSngyazE4M05XVG1HbDJl?=
 =?utf-8?B?bUlpbUpmQlJGV2VtSlFwMFAyeUxSZ0sxcGVZaTZ1WEE4NmxLUU9ock9QL3lF?=
 =?utf-8?B?MDNsbkd6bEJyenN2dHYwMERsZTlZbmtQbEVFUGQrS1pIOGI0QWpQc2NSbEhJ?=
 =?utf-8?B?TE43YlNPMzIvWW5keUFqVDFFcmRhM2V0S244dFdxQ1RDZ2JQWkJocG9TMWJw?=
 =?utf-8?B?MVhmYUxMMDdmek5FWnBvYm5VcDcvM3I2MjBqR1pRN2ZnSHZhK1dpV0NWSDl5?=
 =?utf-8?B?akE2cjRLcWZVZjlUcUNpNWZYUnFNdWhteVJiMTArMDdiMDVwdnZNeGg0UEhk?=
 =?utf-8?B?aVZsMUVRQzlJb2d0YUhKSFh5OU1sNWRPVUllQTQyUVhlZE01d0xxeDJFWE9h?=
 =?utf-8?B?amdIVVc4cWZIRlA1RDMyZ2lwNXgzMkRlaCtrVGNONWVleUhMdlBrMmdCeTQw?=
 =?utf-8?B?UGUwZENuTHd6czdMK2wzTnhRN2NnUUdJdUJDTVU3UG9qWTZNTms5aDNVQXdU?=
 =?utf-8?B?dGlvZEp1aVNDQm1sUmNnR3pDVU1ucGcvamNpVG5QZDJwaTNuZWtLc2syVnZv?=
 =?utf-8?B?Z1ZaUHFvY2I1VjhDdzE5S05jUnI1Q2tQUTZBY3RJdzQ2MkFiT3hnZFBieGJa?=
 =?utf-8?B?NWdSV3BsaHNidzBOT1FHNGhMYUdDc1lMY2UrbEFBYnVtVmNTRlVwQThIUi9Y?=
 =?utf-8?B?L0VNNTR3RU9tbmNJSndFZ2w4TE1JK3NHNFZOc21vNVpUd1Jaek9yV0JMM2pT?=
 =?utf-8?B?ZmcreFhCb3RrNUJQUXVvWUdMKzVHajJaODhRYUhDUTM3MU11NFJVNk8xTzJz?=
 =?utf-8?B?alRBN0wyaWZidXpFSDFQbnluSnlHaElua1M1dGtYYWlQZUZoOE9uRTlPRUdM?=
 =?utf-8?B?VjRFY1lqazMwTnNXTEl6TFlOZkZ2QTc4Y0JiTDNHQzJqanpLaVFRNUhEZUE4?=
 =?utf-8?B?cURVSHRBVUQxcWpYU296cWNXK0tkS0EvSVJGVWtLbWphSmJqQlFTMlpKRzlF?=
 =?utf-8?B?L0JJYXY3aG13VnR3MGt3N2V2b1IzY3p4MU1wWGYrRXpnTXF4TkNpbGRLVzRK?=
 =?utf-8?B?UC9hcDRqL3VPWnBIQ3dkY0tyMFpCOVFFK081c2NoT3FWaEJOVnV4K1NpeWZO?=
 =?utf-8?B?cGNtejUycUlob3N5OWtBVkNUbWJVS3FCYVhKbE4zQ0tkdUVVUzlESjlVUHF0?=
 =?utf-8?B?L2h1N3BVdDRjK0hPTXhWWG8xaG9wYm1lcXVWNkkrVlRLeGNBUy85S01DMXdM?=
 =?utf-8?B?dTRPV1ZkT3gwdDlIdEJ4Y3R1Ui9henNpcW53U0srQXhxQlFORlhmZEEycGRI?=
 =?utf-8?B?OFAralZnQ2o2MjlCUXZPYVc2Y0IvVUhsY29lMW9kOUFJdHEyRlVid3h3ZCtn?=
 =?utf-8?B?MWFTK28wWUo1Mng5ZXZxQTI2MjZMdXl0U1hkaHBNN21VZ0NadVZOcksvSWZm?=
 =?utf-8?B?bzc1MmJTT3NtMURnYUhzUnhJWlljSjB4NnF2dzA3eDk0TVpRcEdBMHBtR3dt?=
 =?utf-8?B?YWRTZUlhS0F0eHFqK3hOdWZ1eUJPSk1lZ0dGZU9jZks4RzlndkxxVEpDSjJl?=
 =?utf-8?B?RTdFUW5uSlcxSmw4YWVRaVRSNG55cDRUVE5BMGxpUE4vZmJwUnRzK3FzbXpU?=
 =?utf-8?B?bUVuVjdwUkhIeWZKbjdsRDJBZkF4RkFVRGJQZ0xhR1FDdDRqWDkzNTIrR05O?=
 =?utf-8?B?SllwK3JQem9Zd3pqSUNmQ0IxNU00TUxqdVR1aHhNQ05qa2RIbVlKTWlyUDQv?=
 =?utf-8?B?Y3A1ejBxZU96VWpDN2t3bFZkckxSa1NCbnA2WkdWTE1aZ0xjZUkvbDRkb25E?=
 =?utf-8?B?bmtNMXBhRUtKWlZWTmJVQjg1cDNERi9mNzRtcDhkbW9NMzB4VnJ2Y3VGcHVj?=
 =?utf-8?B?QllUQmdJc0pkMGdjbldtOXM5Uk5yM0c5RWZiMjFXbFhFL3FXbjZEcjA3cVZh?=
 =?utf-8?B?ZG0wUU1BSVNsVWZrczcvK3UwajVBamFHVmowQXhBL09qdkhGazdESXF4eWtF?=
 =?utf-8?B?VGY1N2xPUlJrWVFMeElQNjVZUmxtZzllbzNMc2VaTmVmTjdNd3c0emh5bGFG?=
 =?utf-8?B?azhVU0lEd24zZW5XYmhFMEhnN0htVm1qL0UxSXppaTBuZWdKOGhhNkFWQWZI?=
 =?utf-8?B?R3FQYmVmS0R0UDRRei9qYkJmVTA3Sm1VM24zOVdwWlc3amliaTZmTHZKTFV1?=
 =?utf-8?B?TW4vUG9IRW9kZitsalRPbVlKYXJ2MUNhUVZ1dHpLUzlXK0owdld0MkFCUE90?=
 =?utf-8?B?cWxxTXpRR1hqaU5Ucm0wNThWYzdERnhWSUEwdGhsbVEvYmM4WXlhVUkrTGRq?=
 =?utf-8?Q?ImckV1RVbbNs2DclyXpkpR+UtskBoG0yP3Ftf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ecdca1-23b9-446c-a4e0-08da2eb4aad4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 16:31:12.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozl541wWYmfFLQ9/AQ7oJc3lF64YSJibANIdZo+ta+qSyKa8pG6M3pUESocxJA753Ykr90TNxWBbi1xFpNtCB0fZE/KPTGA/BPuqVmgFXzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1533
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_06:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050114
X-Proofpoint-GUID: -ZKXpzhKBLVSGPOao9oGNflggnJrk0vf
X-Proofpoint-ORIG-GUID: -ZKXpzhKBLVSGPOao9oGNflggnJrk0vf
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 01:41, Sourabh Jain wrote:
> 
> On 26/04/22 20:09, Eric DeVolder wrote:
>>
>>
>> On 4/25/22 23:21, Sourabh Jain wrote:
>>>
>>> On 13/04/22 22:12, Eric DeVolder wrote:
>>>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
>>>>
>>>> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
>>>> the elfcorehdr buffer/segment.
>>>>
>>>> This is a preparation for later usage.
>>>>
>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>> Acked-by: Baoquan He <bhe@redhat.com>
>>>> ---
>>>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>>>   1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>> index b0142e01002e..f7b92ee1bcc7 100644
>>>> --- a/arch/x86/Kconfig
>>>> +++ b/arch/x86/Kconfig
>>>> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>>>>         (CONFIG_RELOCATABLE=y).
>>>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>>>> +config CRASH_HOTPLUG
>>>> +    bool "kernel updates of crash elfcorehdr"
>>>> +    depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>>>> +    help
>>>> +      Enable the kernel to update the crash elfcorehdr (which contains
>>>> +      the list of CPUs and memory regions) directly when hot plug/unplug
>>>> +      of CPUs or memory. Otherwise userspace must monitor these hot
>>>> +      plug/unplug change notifications via udev in order to
>>>> +      unload-then-reload the crash kernel so that the list of CPUs and
>>>> +      memory regions is kept up-to-date. Note that the udev CPU and
>>>> +      memory change notifications still occur (however, userspace is not
>>>> +      required to monitor for crash dump purposes).
>>>> +
>>>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>>>> +    depends on CRASH_HOTPLUG
>>>> +    int
>>>> +    default 131072
>>>> +    help
>>>> +      Specify the maximum size of the elfcorehdr buffer/segment.
>>>> +      The 128KiB default is sized so that it can accommodate 2048
>>>> +      Elf64_Phdr, where each Phdr represents either a CPU or a
>>>> +      region of memory.
>>>> +      For example, this size can accommodate a machine with up to 1024
>>>> +      CPUs and up to 1024 memory regions, eg. as represented by the
>>>> +      'System RAM' entries in /proc/iomem.
>>>
>>> Is it possible to get rid of CRASH_HOTPLUG_ELFCOREHDR_SZ?
>> At the moment, I do not think so. The idea behind this value is to represent the largest number of 
>> CPUs and memory regions possible in the system. Today there is NR_CPUS which could be used for 
>> CPUs, but there isn't a similar value for memory. I also am not aware of a kernel variable that 
>> could be utilized to represent the maximum number of memory regions. If there is, please let me know!
>>>
>>> How about finding the additional buffer space needed for future CPU and memory
>>> add during the kdump load? Not sure about the feasibility of doing this in
>>> kexec tool (userspace).
>>
>> I may not understand what you are asking, but the x86 code, for kexec_file_load, does in fact 
>> allocate all the space needed (currently via CRASH_HOTPLUG_ELFCOREHDR_SZ) upon kdump load.
>>
>> For kexec_load, I've had no problem asking the kexec tool to allocate a larger piece of memory for 
>> the elfcorehdr. But it is the same problem as CRASH_HOTPLUG_ELFCOREHDR_SZ; how big? In my 
>> workspace I tell kexec tool how big. If there are sysfs visible values for NR_CPU and memory, then 
>> we could have kexec pull those and compute.
> 
> Yeah dynamic calculation for PT_LOAD sections needed for possible memory may not be straightforward. 
> But still I did not get the rational for limiting the possible PT_LOAD sections or memory ranges to 
> only 1024. Although in kexec tool the max memory ranges for x86 is 32K.
> 
> commit 1bc7bc7649fa29d95c98f6a6d8dd2f08734a865c
> Author: David Hildenbrand <david@redhat.com>
> Date:   Tue Mar 23 11:01:10 2021 +0100
> 
>      crashdump/x86: increase CRASH_MAX_MEMORY_RANGES to 32k
> 
>      virtio-mem in Linux adds/removes individual memory blocks (e.g., 128 MB
>      each). Linux merges adjacent memory blocks added by virtio-mem devices, but
>      we can still end up with a very sparse memory layout when unplugging
>      memory in corner cases.
> 
>      Let's increase the maximum number of crash memory ranges from ~2k to 32k.
>      32k should be sufficient for a very long time.
> 
>      e_phnum field in the header is 16 bits wide, so we can fit a maximum of
>      ~64k entries in there, shared with other entries (i.e., CPU). Therefore,
>      using up to 32k memory ranges is fine. (if we ever need more than ~64k,
> 
> Do you see any issue if we increase the memory range count to 32K?

No, I do not. Allowing for 32K ranges means the elfcorehdr buffer is now 2MiB.
I'm thinking I'll redefine/rename this config option to mirror CRASH_MAX_MEMORY_RANGES
and default it to 32K. Then the buffer math will take into account NR_CPUS and this
value to compute the buffer size.

Thanks!
eric

> 
> Thanks,
> Sourabh Jain
> 
