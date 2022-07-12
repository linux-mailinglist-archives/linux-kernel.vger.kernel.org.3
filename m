Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DC571A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiGLMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiGLMvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:51:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF15B6D80
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:51:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCDkSl010416;
        Tue, 12 Jul 2022 12:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4foI6YCk2Bd7T4O4j4B9KrFeFeL/pFwLTlN/yUcuRZ4=;
 b=S7kwrfmF+oXmmkXHoVx+6WexPoRMDEyNBQJnszQAahOsIpXRIfp/O48zyic/BE2L4eU8
 p1BxMmGUs/OKlDXk28FI3dmarP43kQsJO0BDlDHy72X8q08DaciIW0XdVSTE7Jzrw2Rj
 iLrfS7xgf+9Ce0RnsewOXR9FSD0bdndBfrDiWYTN8ajOGUznNJ9jWrtsCfbdeGUlhpYj
 iNS+1fBpI5KXBh3rhvdcylsqNwiMHht+1mgQSQfVIMG4+mRPe8Z6D/Xeij33J9mqlHwb
 uEgyRoN90JcFjFlBty+9lSSQsHH4Scm/jjNKkfpONlXOiYtBcS4k/9y+nEHe0D2WZqSE YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727seswj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:51:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CCfOOU007698;
        Tue, 12 Jul 2022 12:51:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043ppd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBOEYkadUhzpXyBWjJsCtzJ5sm5B8j+drDPewf7UDmuPKXR0qE9VA+SiFbv17DGujlm5+uGIyqhgCDt5h7rqtYs9pTnD8ghkbvd2L1xFMde2EUVy8oaa54aJFRIHO+ZxL/Yp2xR+J07dRoYWsdwOttQu7n+gNQOwNbhfjUgbemCBwzYuCObWS/iDHG5BOSWbELGjY6UyZ+IkPrGzAQqGRWlqxA2K3t/MBWkzBiUOYl1GFMO0oWu92RHNo5OE9wflChpfhuj83mnCLxulSDSiplqt1VnEO78j19SLt375SNta5jfxIWBiqk+Fyo3bSX2NZ2YKX2Gzg0oXIEzSSZX4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4foI6YCk2Bd7T4O4j4B9KrFeFeL/pFwLTlN/yUcuRZ4=;
 b=c6IyvT0NzSIjNHVEAU8m8gb81xPxwmOGvA6K+3Duv4JBx0N0mhzbkvvqohDGm2m5CaXwCQ8SisP3xssl7Pcir8J7tTW8x0qnQ1NzmMwqgkpqu91MqbxoQZO/wqY+0MIEcmWG5WyyIPDKELJI/LHRiBEVZ0Oli8kJGdciN25VmMBsGCB+Mp5JBgDwKEfyVu1yvmZsNJSOK+/vnaO3R4oKKHUjVKgM0xwmvi2fAjtRBf6yKQC4pLrUaeJPwZ1VFMJYh/cvYJBCVrfXGFVjzqoTjSjpqIegPG2biaRz/Ilg5v84eTsUx4jdnVUO5WMIVocj5OHikVtuilpjepr8tN0YOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4foI6YCk2Bd7T4O4j4B9KrFeFeL/pFwLTlN/yUcuRZ4=;
 b=AFeWaK3CubutXw87eaEvSkAaVyOkySBN+eBKEQ8Ie6CKnOfLyuJ7Q1P8hGxMY1LYZxvQbVVJC3nP+ZTLTqLmUDsMoFHyDy/NkWrA7ZAvsdG9duAH3PFwg7Tas5knsizmfL/+YcUoo+TB6A/NHQAyAADrGrUDAt64NL2Y+WQlkCk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4197.namprd10.prod.outlook.com
 (2603:10b6:610:7d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 12:51:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:51:02 +0000
Date:   Tue, 12 Jul 2022 15:50:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Daniel Latypov <dlatypov@google.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [ammarfaizi2-block:shuah/linux-kselftest/kunit 4/16]
 lib/kunit/executor.c:78 kunit_filter_tests() warn: possible memory leak of
 'copy'
Message-ID: <202207101328.ASjx88yj-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0048.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::36) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dde7561-ca54-4622-6b6d-08da64052cf9
X-MS-TrafficTypeDiagnostic: CH2PR10MB4197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eStE2BymIbWBI8E2xU7OQM0r2l0cuYNCrypYpsjI0ECvzRA+BIgLi4kgsSX6wkLQQbQlcDSnU7GZnrWx5KehevmZc8IAAVnWlIc2Y5C8HUyUSHNRnEWq8a6tX5JZnXERT9+Ye7f6A3r3UYkqCbyKfz7wnii9nIq34P6S4x45JsUDQbP5srGAuC+gOcZrcvVfalXsRJLhioJKW7TMqreIdRPTI4ziMEsDJqpHrsUT3Wa5wwSe9nIXpPOcOxGTBgNAlE2Euc+FNYKrUcsM0g+3iG83+3Y+pp/3WpGmnhL43tYUlF4H4PFfz29WTc9cgzk4QQ14d3NcyRY9oiYaBotx1aAdtKxyfQahf7SC93mNdO+j10CH0IpCf8I+3VhY/6TQ1qol4W2zG9vSa5B+pO2gh+lOQ1xi7qO6NQLdWXvkjpZuHd8Qe2Wxuh5DDeXoMI+1ydw/jPVr2XRgQ75tlTjNgwZVwM8ctUHC876dPsNxcPW11egNxXmByA1L5v9nRvDqV/tRGzUhTaJ1SN2Mbx1iNkq8RQmsjh0bU8Fu+kdWWheDmjYDzevVNCTlQl0KdSZWuTCRmAOheWVlNekhdumyyGTBBDCsYrsMpstQgM0HlG/P0UlZBcFZGosP3zlSOh7TVmGIE5IA74Kh5KcUH6OHmEhXBQzyjqh88ylA3hZs4fjGTv4NnXzNV3J32ZIPEe/PLb7Pr3mzCEVA1+sHv7vnOdXMcz0xI5qaUnPpmCMZKpqrnfwCIspfKSEoWpT/XXdvgV2gHB8NxBEV9opVoPoWn9ROsc8MgDwlGez6Iq7GNEFOoy9qmKAn+CtiqyceCMXPl8aPjlR+can8qxQSvFXBSmaNOilC2sQg7eBJt1MnQN2pn5msfseVSoz6zcgfFqpF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(346002)(376002)(396003)(8936002)(38350700002)(66476007)(4326008)(8676002)(6506007)(66946007)(66556008)(38100700002)(186003)(26005)(83380400001)(52116002)(6512007)(6666004)(41300700001)(9686003)(6486002)(1076003)(44832011)(966005)(478600001)(2906002)(316002)(86362001)(36756003)(54906003)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8ZIYDujd/QEDl3+qicMh57CznrtQ8o11LFuJuD4jA9lwF7fdLW1bFfTE7EO?=
 =?us-ascii?Q?qsUX3RKaUMQgh7d9zGFw8ag38LZsdtbo4fHdyPE0vLmkhxKsIKTyYQacTTgb?=
 =?us-ascii?Q?ptXu3+xZtkh2qssw9ZMiyibB2HjHBDOHr/XMfDVZP/bQVQ27CavVslnqYYT4?=
 =?us-ascii?Q?XA4V03+MIouGjbIbi/d9HCC9xJ9vSBAt2GQGjwv2GNc74CtAP3E4580Hzwr8?=
 =?us-ascii?Q?+3Xfy0ILUp34iVUm7QHrAslLpiUQk2og2s7hM3O0VwuHHmPrwz5digg/OP23?=
 =?us-ascii?Q?kZEa6ZhwvA1Iyo+mq4ON7TeeyCxLMjmyQCWzRNYzgtIFzw+7cS9WRZ8iMjyB?=
 =?us-ascii?Q?J1hz4o/r+39lsHDm1UwrEd4zqVC2vnnVO/pvg6n+A5QhNpPJ6hUqkUmt3GhJ?=
 =?us-ascii?Q?Sra/s5NjvA/pLvZ8LgFtjT3ATHq2NN9k9kKGw0aIoX88qlUJC0EVmIPsDL8i?=
 =?us-ascii?Q?dYUFlveVPDzEMZ8ycf4zXswdi4ce9h8dLXNCzZBS95SEnuiBJ+a9FnJShEnn?=
 =?us-ascii?Q?o5oYfgtGZ09mO2u25ocwf16B5UHLTdxSvil3+4x5HXiQpxI2p889BcimuU5r?=
 =?us-ascii?Q?lZTkHwvdMnOe1UrV3WMgr1p/OvWyuyrN++twt4VhpOkv9KbGxQ7e4MsLJdWP?=
 =?us-ascii?Q?of2dLjEirr8jR9JlkAbdhHU6L/SjRQRWNbRYcOa2Z5DK9WgqBPhYJYDPVAWI?=
 =?us-ascii?Q?UpdM4f/3O+nU4r4cdwfrFE7v5+5O28VNr9+IWTiAq4e9YzkZvX5dcIdHzjmW?=
 =?us-ascii?Q?1X8MTrfKJ1mSXoQiX8h2nJNLkMLJ5wp0inoUuQkM19KTZ7+a9bn1s5eK3T/a?=
 =?us-ascii?Q?HhJCySOD7A1nafJ0BCkjurIrfERz5gOjrXVzhUmUO8HpYkbuPJ/nLMTGquy7?=
 =?us-ascii?Q?k5mOKGYRlIkgXmCYRMJZAwmjY3PoGaNrC6R/OX++p7QjA1OBu8Fi523iuvkr?=
 =?us-ascii?Q?UHisSFi2M2coxcs16otsHoxRBNyOh6N2Y+Chw/tVT/wMXggeywZ8vuW20EZA?=
 =?us-ascii?Q?fBKhhOXbrkCZuSGjFq9sulNeJhQZtOU8ThS/rTt7lAB0eigDsQ/IaGDUcr2P?=
 =?us-ascii?Q?dTZySD7IxFI1dvm82bQNANj5h1VxelyRhHMWuhQ3bOwUigM2aDGi7JxN8UQs?=
 =?us-ascii?Q?ug4Yy9UiAzXKTG0keyh1qaiefd8By2F3XQfO+Yn5zg4uI9L23WFY5aKSgeA+?=
 =?us-ascii?Q?o40M931b/OvTe6+7O92ACJl6cB17IcLVvT51wqToRRnXga5M+YXJkIXADylU?=
 =?us-ascii?Q?NIRqB2T3NyiV6s3IAwcBVzluVaT7gnTxi2aCqMlm0ad9Jg8475FJEas5RR09?=
 =?us-ascii?Q?r1uvo+GtcFs7y/4yRUUF9CbFG6Lkqbcr0M30FSgy8RsQQRkyBCwx4qZl1WC2?=
 =?us-ascii?Q?gEyB0obVUz1ocAEW4zB5iao5fNOcDL7lHFiMYZaZjKNh4s0tLNf9Xo8c0Unt?=
 =?us-ascii?Q?m3O6J0wXVtMGbJpJwetRdPBhyA1fFEVOiMeiu4nXbj80n7rUUgFBPnhcUIu8?=
 =?us-ascii?Q?by1BpPPw5Hye0SLeJ1ry24af0Zz7PFUukKsNQbg/0MEQsAkXkgh3eLhSh5gq?=
 =?us-ascii?Q?kn3EgTV1yK1+s0J4dMK/FcwGp7rm1MNg6ViDcG1rexFU87llf/PHMCowjP7l?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dde7561-ca54-4622-6b6d-08da64052cf9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:51:02.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2tIIFxWw/v7vrC2hLZ5qJBT+89DavFE/LTVocGUMOxaVOWlMleRPo3coFGQix0SqzRtD4TnlBE7QACujvGXPlwbS0z+AtmviSyy4HV41u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4197
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120049
X-Proofpoint-ORIG-GUID: IA5duPaD8L8HaRhczHcHbqUjKAyhh6mo
X-Proofpoint-GUID: IA5duPaD8L8HaRhczHcHbqUjKAyhh6mo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block shuah/linux-kselftest/kunit
head:   7635778bac7e46458392c1261e3916e8e9e86860
commit: d2fbdde838f270377de4fc20e919aac3941ea55f [4/16] kunit: use kmemdup in kunit_filter_tests(), take suite as const
config: arc-randconfig-m031-20220707 (https://download.01.org/0day-ci/archive/20220710/202207101328.ASjx88yj-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
lib/kunit/executor.c:78 kunit_filter_tests() warn: possible memory leak of 'copy'

vim +/copy +78 lib/kunit/executor.c

a127b154a8f2317 Daniel Latypov 2021-09-14  57  static struct kunit_suite *
d2fbdde838f2703 Daniel Latypov 2022-05-16  58  kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
a127b154a8f2317 Daniel Latypov 2021-09-14  59  {
a127b154a8f2317 Daniel Latypov 2021-09-14  60  	int n = 0;
a127b154a8f2317 Daniel Latypov 2021-09-14  61  	struct kunit_case *filtered, *test_case;
a127b154a8f2317 Daniel Latypov 2021-09-14  62  	struct kunit_suite *copy;
a127b154a8f2317 Daniel Latypov 2021-09-14  63  
a127b154a8f2317 Daniel Latypov 2021-09-14  64  	kunit_suite_for_each_test_case(suite, test_case) {
a127b154a8f2317 Daniel Latypov 2021-09-14  65  		if (!test_glob || glob_match(test_glob, test_case->name))
a127b154a8f2317 Daniel Latypov 2021-09-14  66  			++n;
a127b154a8f2317 Daniel Latypov 2021-09-14  67  	}
a127b154a8f2317 Daniel Latypov 2021-09-14  68  
a127b154a8f2317 Daniel Latypov 2021-09-14  69  	if (n == 0)
a127b154a8f2317 Daniel Latypov 2021-09-14  70  		return NULL;
a127b154a8f2317 Daniel Latypov 2021-09-14  71  
d2fbdde838f2703 Daniel Latypov 2022-05-16  72  	copy = kmemdup(suite, sizeof(*copy), GFP_KERNEL);
a02353f491622e4 Daniel Latypov 2022-05-11  73  	if (!copy)
a02353f491622e4 Daniel Latypov 2022-05-11  74  		return ERR_PTR(-ENOMEM);
a127b154a8f2317 Daniel Latypov 2021-09-14  75  
a127b154a8f2317 Daniel Latypov 2021-09-14  76  	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
a02353f491622e4 Daniel Latypov 2022-05-11  77  	if (!filtered)
a02353f491622e4 Daniel Latypov 2022-05-11 @78  		return ERR_PTR(-ENOMEM);

kfree(copy)?  Is the burden of random devs looking at this warning
forever more than the burden of adding a kfree()?  Hard to measure.

a127b154a8f2317 Daniel Latypov 2021-09-14  79  
a127b154a8f2317 Daniel Latypov 2021-09-14  80  	n = 0;
a127b154a8f2317 Daniel Latypov 2021-09-14  81  	kunit_suite_for_each_test_case(suite, test_case) {
a127b154a8f2317 Daniel Latypov 2021-09-14  82  		if (!test_glob || glob_match(test_glob, test_case->name))
a127b154a8f2317 Daniel Latypov 2021-09-14  83  			filtered[n++] = *test_case;
a127b154a8f2317 Daniel Latypov 2021-09-14  84  	}
a127b154a8f2317 Daniel Latypov 2021-09-14  85  
a127b154a8f2317 Daniel Latypov 2021-09-14  86  	copy->test_cases = filtered;
a127b154a8f2317 Daniel Latypov 2021-09-14  87  	return copy;
a127b154a8f2317 Daniel Latypov 2021-09-14  88  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

