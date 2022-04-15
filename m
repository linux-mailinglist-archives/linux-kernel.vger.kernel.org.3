Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B4502767
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351746AbiDOJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiDOJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:33:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4959F41624
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:31:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F3m0oV006846;
        Fri, 15 Apr 2022 09:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QxWumrKllwspxlYYV+7SGte8ogFWKUw1q+sOmQKBcFY=;
 b=aIZkJGOpYqFDzXBFxlmJKCtI6G6A+xRCMGmXli2BkfUp5MhdVF9RKpuluerCZRAn/zzc
 y3rsUoS47HgN/fcyIElyqvUJYqR06FGAsCI4/dC16toBJG30y2oSFZK0NXgWhHtCdsCX
 T8MuIQ9mVGXOAcpvN1dswY6noueCQE6L2sEftfwdMXY/HMvfQr4NlLY1wsPrRNfqamx2
 p3v0AoCNv/ba3LWR69jZpEf9NS1nleBwyYLrtDQYfRO16P/XujO0StbnxmPzNt2JX3R+
 bZ9Lqsr+Spk+unvCQSof3FRmZziISCdTXz+bcAv2U/nTAQCASqjGQGmy1Bgg+GWjAd5M /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rseym4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 09:31:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F9QPYB010235;
        Fri, 15 Apr 2022 09:31:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9mjh2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 09:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hskfPHNnp/dwbo8xzwmpFUi1LNUi1VpscRVMV2hjgtZFLeEysmma+Xxhn8wWWbefycc5pOVndPR+ItzCVt8uZna5Twy2YRWbFZQvI86ER0FqNzafzEThsCCixBCxQGPswlipb0/RqkH0WIAOlnZwiTQBa4kR+7javZ6g5mLPU9WXdzUfzGPYZSwcDGoAdpX/QuS7E0Uog7EYn8QK/4v4BpoZiKcmcspK2BwIJEwQWTIr/cjYtYUzBlLiWdR5lY8FqRApg4RVArMfierx/VTZUoExN0gCap7PxUxwqbj9yJVwsKSMB2U5RZvfjxhg4A+ZEh0yJUX1AKqhySSdIL15ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxWumrKllwspxlYYV+7SGte8ogFWKUw1q+sOmQKBcFY=;
 b=lcSNwVh75+Mos5eVIst2uIhEMwdYaFnElgjnMsPPrX5a3/XazAaf98AAyzUTh9xO8B841GACdJpvHoWPwhESFWUxcI4AyUFse/lSdvhg6dm44ySXUZQEZMo3/NNtFtMQP+c8HAX+XYGwNZLXVGFMEcpKDcRmXHT/RLkdreHQgcC2si3kxtumLzcLxeInykYUw/bZrbQd3QXId5v3eclu4dqvtoEIJ/LlHc8EPNU0fSrEoyPSNpWNMlJWOkRrC4JQEUbdohvXotR8CwekVyYlY4ZBcP5uAiBC995YjuMk71RbvTRWdHtzVC956mL0o5TfUKE6+rVTgJoMsh3/Ukc4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxWumrKllwspxlYYV+7SGte8ogFWKUw1q+sOmQKBcFY=;
 b=nHIa6RQgyx3yrvMqsIB3lOICxKb18GxyGCKauI7WSkoeJ7MJP4eVHOUPzUj8/PLKf7Tvzda06vAOf6wb3Gul+Yn92ITkz99xBfXUWr3g3CmXOzpinv7g93l1R6h7gQggGhXXT6TI4BaYOQfwoY2TmQnaVpvUe4IK7uHmBTLMPRs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4580.namprd10.prod.outlook.com
 (2603:10b6:303:98::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 09:31:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 15 Apr 2022
 09:31:21 +0000
Date:   Fri, 15 Apr 2022 12:30:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: arch/s390/kvm/gaccess.c:1064 access_guest_with_key() error:
 uninitialized symbol 'prot'.
Message-ID: <202204151626.pDKgwv97-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3311e968-49a0-46ae-4998-08da1ec2b3a5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4580:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45805A717B2C3195D9A1B8788EEE9@CO1PR10MB4580.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bxeVxYtmRjGKpKRScjJyKXeVH/XLO36lBrzSTJUNF039DgzzKqNeUtdCZKdvbXxJA4VMS8qbsVTpfqBJXUOAeM6MVUGOHaDofcbNf7uIXbKO2liy2SMtCjrYC2N5ZX5edeIDk2ad/D+duUkJs2ad3giNvthdYKzEhedtp6Xmb9IqonjmFSRCU8JsbeLz78SAKEWm4OY73nzBfEee9PoOOzYAIWY0l3a80D9jWzu39wuzKRo1xARexK9uRl+LsnIsjLOQaOTSiPvfmyycD3Q+g+SlyRe4aLHOqTNwHq6kV2v9L9KLsDNQgI6rJlFKmWWEefuv97m9khfSCAsSZxaO4U8IbURBiDte6Tstz0S5npr0OZW8ENxsJ+L2PoZzIgDFW38W0PlnYnumD/0TQgb0ziBzxnaQDQD3DKQ5g904/tLzA5/NQesVZ7upbFLi0CE169D8FaS5iwuyImGYQ8PmLH7YZvFGkVVhSTiO21E1NrZb27Tr76n0GI7/4i1v5bbe+1pg++q7X6J/MJPR9u2jtnQA3TJwTR+SvmG3DDfz1LnCPxldYFTA7aQpAvAHnIJaJRJM0LhAj18X02BqKhAaHj9EbwQzFs4MOo/J/RWH1g2y5/0pmo18rpH33MktvI3YX52MTQC7W/Gqi/CCTI0o23BXKptRiEIQLKz1Nl6akrb+o9CTiHz+6L8ym8Nj9ODGXeHP/gu4pMQhPszmPaU/uhd/DIWeRhc21K7K7HL4kTLao6/3GS4gWcfnP6h6Q55kPAit3ARXPoy3mephMB7i1dk/4l6+LjiwiXZIlUNcUjXCAGMbphtsoz5Ci1ujzzxZZs/cEZnP3vRr8r+mhXEAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(4326008)(26005)(1076003)(4001150100001)(186003)(54906003)(8936002)(5660300002)(316002)(6916009)(36756003)(6666004)(86362001)(2906002)(83380400001)(9686003)(52116002)(38350700002)(6512007)(6506007)(38100700002)(66946007)(508600001)(66476007)(966005)(6486002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zu3TOpXDPuFCsUh0SZIt2V9h5mnbC65xlaPS1Fc0sKPNmeYfF90bG3gINhqv?=
 =?us-ascii?Q?pwY9gv48hEoD9ilWyUzGlCpzX8e5KA6STh4k3OOU7Jk5dE8VIkWTdcSu5nnj?=
 =?us-ascii?Q?ZVZVDsO1J77dqrVF0yi9VGvDWgyTDBFGQPQLyNbiDKn5YYfKCcEPY5lrOhOv?=
 =?us-ascii?Q?Bm6NI1NQzBQqKcc+yKEv4tGIp428V6QI4xFkjg4HBDNIqcxH/Tg3JjbqN2kP?=
 =?us-ascii?Q?GoSuSPZRQ3TgPKYbXfPjh+ztB7t4I5YGA8oQVEFde7bUOLAkdLtwRI/oHSWR?=
 =?us-ascii?Q?gJf8uyhDfl79cjQHlw+KUElZNmxi80BBmRwgnD+fhSf4zkJONSk4gg4kUwRR?=
 =?us-ascii?Q?mzVnzsQlsVZBhdw2TBvEn5Kg3Ttv+iIZrOLEi4xw7LCpWawqdflTpPcYONmc?=
 =?us-ascii?Q?b7lw1oNEIeXeqIyA8BnL/XVTSJNCD4F1s3hLOzvz/ZRLiby2nswSMlziF/Yq?=
 =?us-ascii?Q?nHEirue5E/kck8A0/KSYmrdoVLakNgj9abHctPlEN5A9D3su86GY5mT4Fsbp?=
 =?us-ascii?Q?5mEkKjempINF9+saN8cGTigHKAImh/bQm4l7c5s+rz+xxwZvYxq4zZqNOR27?=
 =?us-ascii?Q?xymo2t9bFW6UH0MTthNXaarDNVwTDi5Ger8pGGK2qnznv7yguZF7vApceWiJ?=
 =?us-ascii?Q?QkZTrUAxVCOCL+bG/tGY0hjH5mm8sluiVzGo7vaQhE/1ivLbsh2lE29rbTsw?=
 =?us-ascii?Q?eO+CbpkD3JUhIg1r5l+Jakbw+Vj8f1bsiLLIiwGE4BgD7yjnxr2XZofwNA18?=
 =?us-ascii?Q?BdwXgkvytha9GJ/vnh9ZjgD3fupm/2PmkM6ci6+nyhXIgEWKr7thGbtLh8CS?=
 =?us-ascii?Q?WhLmlZz/1Mdj8mcc6tbFxPImaQlP1p522lzBWpBDWm+731cm3KaomgY+xd6S?=
 =?us-ascii?Q?pgVZsuGgXLHg88ldIORgAeWecZsSBasJ2mc31oOAzIAdAi7vXRLE2stJ93Vu?=
 =?us-ascii?Q?1IOxAvw5rJVewQJv6GzNsnaUMu/3zDO9FEaaK3zeAtqs1cx2e1vwxT0cslEm?=
 =?us-ascii?Q?5oo2//YOBGH4xE/M4EciV1x+ONIgO8uagI70kXndeHvy6G2Mjzy8hWnQKa/y?=
 =?us-ascii?Q?3vekVpkE5WzmZrrUn7dLioMg163VOQf7nwMKI7JeqtFZn796muhjwnqPp8lC?=
 =?us-ascii?Q?yHbeWZVv1yAYfTL2Jy5K86tBERyNew98WMbQRO/Z9PUTXAD2FaNnhyb4djfO?=
 =?us-ascii?Q?nUKDYwXR2Bf1y0Up7iezgzWj0nKRiX7ABz/0wn14X8J1agtguri/ZLuNrJJA?=
 =?us-ascii?Q?yJgmhl89ufsqeKqNwJEz3VkMsOeAua3y96UDVFONqhB1ex+Eaxk+0VvLc6PS?=
 =?us-ascii?Q?iReIoTtp6gZDPu6lX5jlmi8Q3wWrHkB7jOmO02A77iNalpx9B4H94Wy/8kFg?=
 =?us-ascii?Q?Syqfi1+zxTlankijmJ0U1Ea8MFMajiAr6IzHlHzF4Wa7w/rERB0d0ThOFjuy?=
 =?us-ascii?Q?0Gb2CLMxy2+5qqM49y1ahG9f6niW9SgbotQKGKVz/yJQ9msU0ORjaKtI47Bh?=
 =?us-ascii?Q?zK51v4y2V+U4iSvwk+rIFAFQE9hKfYAsKLubaSl2RiQfIKd3kjCLsb1FZsqr?=
 =?us-ascii?Q?XqONQLiaQ2wKPst4I1U3imLxhocqMN+W5cICozyY8ikcUHq4KoCkt/DgOLFA?=
 =?us-ascii?Q?X5EmKPP2EXUNgBC/zurWtEp7tV0XPbZLyNpvtdXCtp9O0pP3KaaoFflmi1Oh?=
 =?us-ascii?Q?7LzH7xH6o5amftEjmBhF+78MbHvwVoZR/kYrGRRuSvMkCHyLTL/3hRo9y1KR?=
 =?us-ascii?Q?Undz8dLC9sQ3Efr2YWaGW6rNRUsTxHw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3311e968-49a0-46ae-4998-08da1ec2b3a5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 09:31:21.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVc6NzjCLgDTK4+s6fQh3/O8gVqw/x4Xdgrf2GfZA9P9OK9LLn3vZw4nAxsyfOMISn9KJWV530/s1oXOig4G7WnDrQpHv0PSwsx1myE7GJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150055
X-Proofpoint-ORIG-GUID: JgPAa4NspIDnQL_tEumUeS-4gNb16_hl
X-Proofpoint-GUID: JgPAa4NspIDnQL_tEumUeS-4gNb16_hl
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   028192fea1de083f4f12bfb1eb7c4d7beb5c8ecd
commit: e613d83454d7da1c37d78edb278db9c20afb21a2 KVM: s390: Honor storage keys when accessing guest memory
config: s390-randconfig-m031-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151626.pDKgwv97-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
arch/s390/kvm/gaccess.c:1064 access_guest_with_key() error: uninitialized symbol 'prot'.

Old smatch warnings:
arch/s390/kvm/gaccess.c:935 guest_range_to_gpas() error: uninitialized symbol 'prot'.

vim +/prot +1064 arch/s390/kvm/gaccess.c

e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   997  int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   998  			  void *data, unsigned long len, enum gacc_mode mode,
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11   999  			  u8 access_key)
2293897805c2fe Heiko Carstens           2014-01-01  1000  {
2293897805c2fe Heiko Carstens           2014-01-01  1001  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1002  	unsigned long nr_pages, idx;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1003  	unsigned long gpa_array[2];
416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1004  	unsigned int fragment_len;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1005  	unsigned long *gpas;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1006  	enum prot_type prot;

Maybe set "prot" to a default value?

8a242234b4bfed Heiko Carstens           2014-01-10  1007  	int need_ipte_lock;
8a242234b4bfed Heiko Carstens           2014-01-10  1008  	union asce asce;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1009  	bool try_storage_prot_override;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1010  	bool try_fetch_prot_override;
2293897805c2fe Heiko Carstens           2014-01-01  1011  	int rc;
2293897805c2fe Heiko Carstens           2014-01-01  1012  
2293897805c2fe Heiko Carstens           2014-01-01  1013  	if (!len)
2293897805c2fe Heiko Carstens           2014-01-01  1014  		return 0;
6167375b558196 David Hildenbrand        2016-05-31  1015  	ga = kvm_s390_logical_to_effective(vcpu, ga);
6167375b558196 David Hildenbrand        2016-05-31  1016  	rc = get_vcpu_asce(vcpu, &asce, ga, ar, mode);
664b4973537068 Alexander Yarygin        2015-03-09  1017  	if (rc)
664b4973537068 Alexander Yarygin        2015-03-09  1018  		return rc;
2293897805c2fe Heiko Carstens           2014-01-01  1019  	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1020  	gpas = gpa_array;
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1021  	if (nr_pages > ARRAY_SIZE(gpa_array))
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1022  		gpas = vmalloc(array_size(nr_pages, sizeof(unsigned long)));
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1023  	if (!gpas)
2293897805c2fe Heiko Carstens           2014-01-01  1024  		return -ENOMEM;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1025  	try_fetch_prot_override = fetch_prot_override_applicable(vcpu, mode, asce);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1026  	try_storage_prot_override = storage_prot_override_applicable(vcpu);
a752598254016d Heiko Carstens           2017-06-03  1027  	need_ipte_lock = psw_bits(*psw).dat && !asce.r;
8a242234b4bfed Heiko Carstens           2014-01-10  1028  	if (need_ipte_lock)
8a242234b4bfed Heiko Carstens           2014-01-10  1029  		ipte_lock(vcpu);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1030  	/*
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1031  	 * Since we do the access further down ultimately via a move instruction
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1032  	 * that does key checking and returns an error in case of a protection
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1033  	 * violation, we don't need to do the check during address translation.
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1034  	 * Skip it by passing access key 0, which matches any storage key,
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1035  	 * obviating the need for any further checks. As a result the check is
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1036  	 * handled entirely in hardware on access, we only need to take care to
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1037  	 * forego key protection checking if fetch protection override applies or
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1038  	 * retry with the special key 9 in case of storage protection override.
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1039  	 */
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1040  	rc = guest_range_to_gpas(vcpu, ga, ar, gpas, len, asce, mode, 0);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1041  	if (rc)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1042  		goto out_unlock;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1043  	for (idx = 0; idx < nr_pages; idx++) {
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1044  		fragment_len = min(PAGE_SIZE - offset_in_page(gpas[idx]), len);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1045  		if (try_fetch_prot_override && fetch_prot_override_applies(ga, fragment_len)) {
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1046  			rc = access_guest_page(vcpu->kvm, mode, gpas[idx],
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1047  					       data, fragment_len);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1048  		} else {
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1049  			rc = access_guest_page_with_key(vcpu->kvm, mode, gpas[idx],
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1050  							data, fragment_len, access_key);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1051  		}
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1052  		if (rc == PGM_PROTECTION && try_storage_prot_override)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1053  			rc = access_guest_page_with_key(vcpu->kvm, mode, gpas[idx],
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1054  							data, fragment_len, PAGE_SPO_ACC);
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1055  		if (rc == PGM_PROTECTION)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1056  			prot = PROT_TYPE_KEYC;

Is PGM_PROTECTION the only positive value that "rc" can be?

e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1057  		if (rc)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1058  			break;
416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1059  		len -= fragment_len;
416e7f0c9d613b Janis Schoetterl-Glausch 2021-11-26  1060  		data += fragment_len;
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1061  		ga = kvm_s390_logical_to_effective(vcpu, ga + fragment_len);
2293897805c2fe Heiko Carstens           2014-01-01  1062  	}
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1063  	if (rc > 0)
e613d83454d7da Janis Schoetterl-Glausch 2022-02-11 @1064  		rc = trans_exc(vcpu, rc, ga, ar, mode, prot);

Smatch is not using the cross function DB here so it assumes other
positive values are possible.  Also "prot" might not be used in the
trans_exc() but smatch will still complain instead of checking for
that.


e613d83454d7da Janis Schoetterl-Glausch 2022-02-11  1065  out_unlock:
8a242234b4bfed Heiko Carstens           2014-01-10  1066  	if (need_ipte_lock)
8a242234b4bfed Heiko Carstens           2014-01-10  1067  		ipte_unlock(vcpu);
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1068  	if (nr_pages > ARRAY_SIZE(gpa_array))
7faa543df19bf6 Janis Schoetterl-Glausch 2021-11-26  1069  		vfree(gpas);
2293897805c2fe Heiko Carstens           2014-01-01  1070  	return rc;
2293897805c2fe Heiko Carstens           2014-01-01  1071  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

