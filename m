Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73C0526F4F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiENC6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiENCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:55:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92435326E71
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 19:34:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24E1uPkG014158;
        Sat, 14 May 2022 02:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cgqPCP3tT+Zuaez1zVSdaesB5qCjT220JkLszKaXsrw=;
 b=tbfk0WKz8YwIi7aH+o0q2BEyO3XB6No6r1ENjO5uZzl7X64y4rIO2CR7rSsYUFI+PbZH
 4BsHm1TYLXQQIHgs2WGH6F7CYQa1NZ7A5zIN+NO33PXatP2LCSdit4kv1umkAP21RcFd
 A+3eDVN9mVkTLW7vKNpwn0LlqauSsa7sIS/DZVJiM2w7xjrQoN8s3U1RUirdY65Ur8rF
 pstnwPeqzwr4tCiaS8rFc6vSxrA+dcwQl5nZgO20BtRXqh3RfPCg0TTsu8EOTBStUUrl
 wHu1Bpd5s5M10Cp+AO5Xp+0zNHr5D8N52Mq5UuliepFxuAgS3KDwVuXfKCbAFzkZnHoi VQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371r0mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 02:34:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24E2LXSd022121;
        Sat, 14 May 2022 02:34:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22uyraq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 May 2022 02:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD1jdNOgTF9aDfyye/5LoMp9bwaC0Vz5sMwBs0UO6P4rbiBWRSaP3AAXwljkjq0ruw65tXYRaV4uTpFT0Y+LgLC298qdCPCxPtNr9ZrrQHx7FbKK+bRbpBjlgW630DUjE8BpKSsn8w8iPFTBVmTQoChOWYqjA9MUDAQXbUEN+P8JdcmSK3GaPXtRqZ2KJO8xVqxqOAU+UPOq0VIRmXnXWCKoPTDqKg5+7hyQ5Vp5yGEKaLEJLwacNJzCQ9iLMOaOFnDYI58i7pyVulWegGG60d517pqHq96K4LBXJbvgirD3ZSf/RNYILHF5HtB7pHjMr73NetPyBhZtofchO2VVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgqPCP3tT+Zuaez1zVSdaesB5qCjT220JkLszKaXsrw=;
 b=BSmwJO4imFqjAx1CpEAsXGifiXE280wOpIdNu88Nqhsiw9BJQVq4+07WO4rveZC1XT3e27zVDdxlqztzvJzuPEcNAIv8i1xepw0fiB47qYba3iHfSgXNCM/VObgP3gQuxlOpkVZlCa0Wmntt0j0Ak8eAI+ZDItyalZDQ3CFOXbhKxTC6b6CIGCpk3heQq2hv+qUWHDTG9arlbVf6laiD5SE6Q0H61Kv1ZXDf2/M67V9j6jgLG430Xd+cIfvMb7oAOlha2eYw9/U/uSNINmACBOkyx4jC7xVt0Kj0FWaaJQndy44bX8qHGwN1yh2uduRgdxxgpn+PW4NbpDneI5k1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgqPCP3tT+Zuaez1zVSdaesB5qCjT220JkLszKaXsrw=;
 b=Sc3YciztoofzciW3PbZQWdt+EgumncWg+NNSyX6luhNum1KZmQmrMPyTYt8eCmOgIdiqtLQTd8B9P7dyjPJAT3w5sS/c4vOPqipdhr9Tj9qOseILq/r60M7KxeWoHFfLJ8/5Pmb//99uVx/basOMLzi4yMJ3x6idZ8cFJWlkyO0=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CH0PR10MB4825.namprd10.prod.outlook.com (2603:10b6:610:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Sat, 14 May
 2022 02:34:21 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::125:f19d:8eaf:b8e4%3]) with mapi id 15.20.5250.016; Sat, 14 May 2022
 02:34:21 +0000
Message-ID: <91f95228-215c-b817-8bb6-8e24c0caf925@oracle.com>
Date:   Fri, 13 May 2022 22:34:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 2/7] xen/grants: support allocating consecutive grants
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1651947548-4055-1-git-send-email-olekstysh@gmail.com>
 <1651947548-4055-3-git-send-email-olekstysh@gmail.com>
 <597125fd-4c85-fde0-9d5b-a9cc13a81ccc@oracle.com>
 <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <d1d61bcf-86f9-68cd-9bd4-a13bf8149b88@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efe6e20d-1489-4578-90fd-08da3552407c
X-MS-TrafficTypeDiagnostic: CH0PR10MB4825:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB48252252BCFEAA414290D2FD8ACD9@CH0PR10MB4825.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muemePyPhjhrXLdKT8hLrb1nyr+LnSMaFeqotA1Sot5Els5DH4InlLPPTzA5E0ykXBKwvlle9QXLzP4DgLLS9a1+qD1oUg8v0uudliITmwLkI6yXb94bMv06y9hGXuJt/YIsBPKDNpyr/AWJaIK8wLEhCA3oxqZlmWBozw562PA6CERcnWtZR0zqQZp8uD5GBrRU6kw83M9IdUFiBW6/6ga/KcQ4obbb/Sbs5XgirBMZAoIgB9N6+5XlSD2giz/V0fPOVbuFtzZGJ9Bj/G5p0yCQaqXoPknrxnkawZW26QsN9wcMzdFe2pnLWtE5qT8GTa9DzBrn3J0EpAGKu9cWOEe+02ecVasfX3r284kZX+MGKtJwQAqDkSlXQCTU8KUXfkc+tUBw3v61ZrzmI56elRzd1aS4FnQhysYJj2UJivNO45xXViSeOP57zRFv6hfcKpzwApdTsa9Ha9s/b+/b2u6BWosRv42rXfPNyvCZXGiVIbYoCI3dW2SmkCO7Ox9wnXF5mUoFVLGdCaEnCwjN36R0z83s8zL5CVreA+dXrk1EwM70H7HYP/w+m4b3lyPaGMmDKT6Mc/vOCQXFkMIjE0nAopWm3VjmSiM/txXxMHadEdwBqTgkU36rJMMWdJ2nnYzVkgGZphkHtdQbl03vkQLiVkHWcZ5da0wxzfuCF6YX6aamwadr1u+Iz1/IhR+4s+yRosLH1z85McKEEhjYj0rigoNQR3ykbAwwxoSUnWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(31686004)(83380400001)(110136005)(54906003)(4326008)(66946007)(2906002)(66556008)(8676002)(66476007)(44832011)(6486002)(316002)(508600001)(5660300002)(7416002)(36756003)(2616005)(6512007)(26005)(53546011)(186003)(38100700002)(86362001)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGRET0NDNHVBcDJqWm52WElxeDVzTHVnTzNTRDZ3aFpIbHY1NGFHZ3pjOGJv?=
 =?utf-8?B?KzBFVUs1elVoTkpqdllrM1dNbDdZU1R3blBRWFJLREpGbk1nZm1sblUxa2pI?=
 =?utf-8?B?Z3FkQXBwT09La2M0QTlaRHIvdUtnVmd6VnJTZ2x3MnlmZ092NGM1THU0dlZO?=
 =?utf-8?B?WEVoSUk2TTNPaW1QeGZiVzh6RmEvZ2QxSS9JVHRIUUd5Y2xhR3JkWkJzZUZC?=
 =?utf-8?B?OEN3MTZWRG52VmhwWGdZalFlamY5TkhHMnlPTzBSY1ZOb0dWVmp1YXdFYVJu?=
 =?utf-8?B?dVBackY2VmpIcE5telVpa0FycDF5b1RDZ0ZaTS9IN2c0MGw2Mm5rL0d4L1Qv?=
 =?utf-8?B?bmYvbVpTR3BzSVEyWjl0WEc3QnkxTHU5djZib1BOemRqNVNydU1Yb0dJaXNQ?=
 =?utf-8?B?UDlVOGpWSTh5Y1dpS0F2clJ3ZWtWQmZ6SXlVcGJVR0N6SDdDWVlOVWlGOXZv?=
 =?utf-8?B?WStjYmxCVkV1RkFPcjVCTm52K0I5QXBHZkwxZm90MEEyRmJ0UmcvMDBsZEta?=
 =?utf-8?B?d2phQ2E0bGVDTUE2dGNhcTlZbm50cGw1M2FGOGJ6Skhkb1llZmNTMHo4czVo?=
 =?utf-8?B?ODYzU3VNQ1dFS2RYcmltUTVqTDUxM1FzcHZLSzJoc1ZETUdIT1E0SGhrMDhj?=
 =?utf-8?B?ZXRFN1Zyc2RoNjJBTnNHdjk2cEpISm9NOXpMT2VVa1l5K1hlYmE2VlM5SndK?=
 =?utf-8?B?bWFOYnd3OCtWbFZzSUFSQ1JXN1FEdGwwVDNxSHN2TFVDTlJMZjlQSXAxWjYr?=
 =?utf-8?B?SWFTWDdnMG5haFBGdHExczA0cjg5aFBnMmVnazF5S2V2Y2xWOTMwRjZHMERV?=
 =?utf-8?B?bjZzQncxUmF3RDJuUFFoNjYzVHJtVWwxbjNZVG50TFN4Y3NFeWJSNWFHeWZi?=
 =?utf-8?B?eUQ0dU9qWVNiTjAxdWwyM2ovb0g4TWlMN1FCVnNPcFJ4TCtBTVRMblh5VjZS?=
 =?utf-8?B?U1pMS1Q5WGRrTndSTWdPUk8xcWdRRVNpRUhENERNQzN2bndEdmhYK3MyQ05h?=
 =?utf-8?B?d1hKdWN2emVJRkpRT2xhaHM1SnJXMjdpUHBNY0xodmlkc0hHazgzQzA0MmJO?=
 =?utf-8?B?dk9BTzh3NGtNSTZibnR3VERHN3diQXgwOTVJNnBteG9NRElpeTd1TjFaUTVo?=
 =?utf-8?B?bE1mOWZOWm9od1RaWUZQY2h1UTZSUE15MzVBVVRmQkpzclV5Qk1INUlVN3JZ?=
 =?utf-8?B?RmVCV1dwckNIVUkrTTRrOTJLNE1hWUlTbFNCcXBJWnBVb3FteDFzbXlpS1ZB?=
 =?utf-8?B?MDdCempoS2VrZThScHVqV1FZYjUxU2IxTWNHMkFvaFQzbDNHNCtQMTFOZllj?=
 =?utf-8?B?NVRWQ3hXTDR0KzBQOVZmNEJZR0EwVkJOdTBuTGJ6K0lEYjRWU0tYb01JU0xZ?=
 =?utf-8?B?TzZKSWdmWDhMR3BkSVhReFp4dFZSay9MYTcrb2Q2WG5OU3RaSC9aeUpLRGNQ?=
 =?utf-8?B?WXZsRzVDSXJLTVpsZjMwR1ZtckU5cHZlMERJb1VKc0I4cGREa0ZoQ1NiUkdW?=
 =?utf-8?B?TENHZFMvSUNpdjUvU2VnaXR6MFZ3L2VmUzAwZHg5VC80eGRucUE2QzhibnFt?=
 =?utf-8?B?MUV5SjV2RkZKSWZEdzQwdUdTczZFemNMRTkvLzN4ZDZZQWF2djJ3Mkk4Rzdq?=
 =?utf-8?B?VUt2ZzZRMVVEbGxESENUZXVMcERJejh5SGVsck80VlcvYVo3MC9ZVXpaY3Nq?=
 =?utf-8?B?ZmFKbWNWMkxWSnAvWmRYNDZOUEVmL0c0cndxQ0F2cXdROVU4ZmlUT3BLN1Vk?=
 =?utf-8?B?eFovL3hQU1BINTd4dXdUbW1PdFo2SCs3eVFLcE93TlY3WDFlQ1lScWo1L2VC?=
 =?utf-8?B?Y3c2dExtRFNBUHMva0RKQ1hvZ1BUM0VFTnVUaUEyeWVyVXl2WEsyeFkyck1P?=
 =?utf-8?B?aERRczVkVXFZSi8xYWZTMEd0Y3lFSzdEam5IS0ExaGVDTVhadURtOHhlRGtt?=
 =?utf-8?B?NEh1dGp4Mmo0Mk1YdVBJZFJ5cGVTaE5ZR045V0t2TWVrRHhuYVRLNGt0UVpL?=
 =?utf-8?B?T3pvL0lZb3VqNTJuUjl3WWQrS01tUWtZZ2dYQUxMT3lVcjFia0tIUHd3dWtT?=
 =?utf-8?B?Ynl4ZkxPdWVGWXIrMUJHazNIamd4Nk5rVWlGWU15cXZ5d0F4bms5R0p3Y3NO?=
 =?utf-8?B?b1RnOHJnZnVGc3E0UVBMbHV4Qy9RaFEwb3BHRmN4QU4rZXV2NGYwUWowNEoz?=
 =?utf-8?B?ZFg0K3VCV29rVDNhcitkVkV0V2hOSnovNUJIVHBkUGZCbWRlTVYwMnZjYmZr?=
 =?utf-8?B?VWV6clpyQTJaUnBDendpbE5RTllpMVBqNTBteEkreTdiR2J5OXUzVTNZK3BQ?=
 =?utf-8?B?UE80dFdYTUR1MmcrZHpsd3Y3aGZnZ29EMzYxRXZxbW1DQWk0WDI2dzFOSzFI?=
 =?utf-8?Q?kMiEBFpvaS8qa+bU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe6e20d-1489-4578-90fd-08da3552407c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2022 02:34:21.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU7pW8pRwHFuCXIBuUG3P1X1VIGpe3DICoh+sj/CmsPvmqsR8A01nCObhV65O2U5dDCvVU+f3s1VN2u5NgjPKZhW8WDJo56cirkEp5YB4o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4825
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_08:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205140012
X-Proofpoint-GUID: GN7K3KiDBj9kiXHe3DJ6yk4_YdSpBSqj
X-Proofpoint-ORIG-GUID: GN7K3KiDBj9kiXHe3DJ6yk4_YdSpBSqj
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/22 1:33 AM, Juergen Gross wrote:
> On 12.05.22 22:01, Boris Ostrovsky wrote:
>>
>> On 5/7/22 2:19 PM, Oleksandr Tyshchenko wrote:

>>> +/* Rebuilds the free grant list and tries to find count consecutive entries. */
>>> +static int get_free_seq(unsigned int count)
>>> +{
>>> +    int ret = -ENOSPC;
>>> +    unsigned int from, to;
>>> +    grant_ref_t *last;
>>> +
>>> +    gnttab_free_tail_ptr = &gnttab_free_head;
>>> +    last = &gnttab_free_head;
>>> +
>>> +    for (from = find_first_bit(gnttab_free_bitmap, gnttab_size);
>>> +         from < gnttab_size;
>>> +         from = find_next_bit(gnttab_free_bitmap, gnttab_size, to + 1)) {
>>> +        to = find_next_zero_bit(gnttab_free_bitmap, gnttab_size,
>>> +                    from + 1);
>>> +        if (ret < 0 && to - from >= count) {
>>> +            ret = from;
>>> +            bitmap_clear(gnttab_free_bitmap, ret, count);
>>> +            from += count;
>>> +            gnttab_free_count -= count;
>>
>>
>> IIUIC we can have multiple passes over this, meaning that the gnttab_free_count may be decremented more than once. Is that intentional?
> 
> After the first pass decrementing gnttab_free_cnt, ret will no
> longer be less than zero, so this can be hit only once.

Oh, yes, of course.

> 
>>
>>
>>> +            if (from == to)
>>> +                continue;
>>> +        }
>>> +
>>> +        while (from < to) {
>>> +            *last = from;
>>> +            last = __gnttab_entry(from);
>>> +            gnttab_last_free = from;
>>> +            from++;
>>> +        }
>>
>>
>> I have been looking at this loop and I can't understand what it is doing ;-( Can you enlighten me?
> 
> It is recreating the free list in order to have it properly sorted.
> This is needed to make sure that the free tail has the maximum
> possible size (you can take the tail off the list without having
> to worry about breaking the linked list because of references into
> the tail).


So let's say we have the (one-dimensional) table of length 13

idx    ..    2    3  ...  10  11  12

grant       12   11        2  -1   3


and gnttab_free_head is 10. I.e. the free list is 2, 12, 3, 11.

What will this look like after the 2 iterations of the outer loop?

(I am really having a mental block on this).



-boris

