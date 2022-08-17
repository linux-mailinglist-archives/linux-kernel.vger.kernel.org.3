Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9018A596C46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiHQJtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiHQJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:49:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5AE5A2C5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:49:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H7Flgm019439;
        Wed, 17 Aug 2022 09:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=lltSGyCdtm0WvIQShl4QK78COzEEhQHmDxBROcqmvnk=;
 b=AnEruMRc6UBiZjMAw4YXyieSuT1wj2i3Nxnd32YFJ0d4C+g3GuxbcQhN3ZAfExoQesjQ
 mpNmVEkhA7D9t84ok++yeZtZuO1Pc5+gm1b7iRV0vF0WSp99g5OZPSFvBJXZlm+F4t0L
 ckbcvG/ajnXA1YWHUaA7cirGGcrBNrYEWZaBrE+K2V4xCD9wsz6gARkIkmKd8aNeINfv
 nBq4COPnDPStZyVu4ztaUHk/YNT6pTurs2W0zrGCPcr1WGM/M8Jp9z7KRqIm8PZJw6Rf
 EEPMxflYWYTU2Nplt47fSU6ZDXwM8pt3YvW2BWvkbI4QyXJT+BfD469S0N31gS1Q4Oc0 eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j0nt90v0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 09:48:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27H8tQMi032697;
        Wed, 17 Aug 2022 09:48:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d3c7rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 09:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axjmKbYjCmNBmEG94UmXtLqF3I7vkbddmT98QV/CINZsVZiJIPqOQ6HkTpDMSSPpslHrt0vs7PYgf/Bo10N/IbvLDxDPai5jmRQJzYeytlp9eNI49hjLm6vfjhkR6I5J34RmapW7LRmuRBnb+0OlaA0At89hf2uPpRFldgXxvzBvJRmZusaGjtXl9pYu8x0qatebT+9zgu8EwycOwhm85wCCDpmnCBZCYb35K1z0oQ81hzkbQq7Nrjj42DZpMMzWwIgUa0wa1xsbeTXeVQx9EsBkInvK9FOlvxQPKqvjJBdscnhMC6l0yLRJ2vkFXkimCADhPBJL/jlYA/KBbGRGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lltSGyCdtm0WvIQShl4QK78COzEEhQHmDxBROcqmvnk=;
 b=TPce30Fll2NiwO1W8Urr90ZxR6q10xeXaXy92rukCHFF2KosLcqOwezTLUy8y7IHubqMx1+/8K5CxPpiGs0gKsqMfwT+onmQdRpEjRe8bFRXy/UDu4/ylj8gqKPtGbr/Z/A9uwVgHMwsSq7WHAGk/AxDVMee+aABt8mi4uM2BwPLIvaLFpt0DPNvduapWPtLFxNvSsnjMO3t5zzBrhJxdumr0Qc5nqsoWegfBHl1WBqg3S5kkRr6cDBPljmcZPT559qFoGmsM1/fbinPw9oeF8CrwXcf5KxE4FTrozkO045mvfMeEOsi6k1NucdoD+te8Y9/uvelE8/ItLw5FFuRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lltSGyCdtm0WvIQShl4QK78COzEEhQHmDxBROcqmvnk=;
 b=eFrehg8fOqfBhEm7bbQxVYgDTjg4mJIdahjGyXamXVzwwHQ5xLUFJHhZpDkYUaIqJUdYdCwbZTT39AP3PB3iDJw0+SXMjsHWJckxd84vIARWtPApShBReVeGCRXFACfCyYWFfSii7zSaOEYhWKqEZ4s6T9GQ5wIBSgAvLoK3eUs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN7PR10MB6619.namprd10.prod.outlook.com
 (2603:10b6:806:2ae::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 09:48:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 09:48:03 +0000
Date:   Wed, 17 Aug 2022 12:47:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Matt Flax <flatmax@flatmax.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-sound:for-6.1 3/22] sound/soc/codecs/src4xxx.c:288
 src4xxx_hw_params() error: uninitialized symbol 'pj'.
Message-ID: <202208170317.bCGqTwpU-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ffd2b1-cdf6-4900-3302-08da80359423
X-MS-TrafficTypeDiagnostic: SN7PR10MB6619:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLLqWKqbyvybly0wxEYTpDd4TiHuNiXtFFIQtMSZFuo+AkV8JWX7z0xWyISDyX/CKVmqKFVcsB71m9IYHHwRx77p6JnIKIM3hXQQ7OaN+F2sEStLBDOZYlf3EzAFN6gA8+JGLcLvYzDKttOqsuUYlCrddy7wFzlPXBxHNRbPek7IBRrQTyAI8xKnjmGYEbG0kaVgWayort1f5/1vIhYf7ubsHUpltQn7AieQ53NpSLKo6D0O1nJ/gw4JeDhCZDK8QVHa0sKG8Av7X+q0TVe96fOePUg+4hv/iCHrQBJ21484x9WklcGU01JNQorv1Cvf8Es7YV79Rdc89IWjos4bTzM3e8TgIZBTxv6/B/Z667tu/kXOenTGVjGV95og7oJZ+nwgqcTyh1E6ik3jcCyGwETGg4Dd/KyxhFBUodktgnpdpLl4X7oSdDoxXiU6yyxWJc1FLiiIX5ZI8GeJwF0Qz4mvpTflAKj2mO8P8gD4sza90ZjM+8COPOJ8aYH58BAfwTc9ou09cZNpVAQxTCrPkzjiykLyExCPQ4vvHrvQskf00J3EMO+B3l+G901t340qsmz/QnC9d4lVrRlJkDbPS4fGTWAfatnY68hXXjt0erCAOjYt4DVB4jzWauvX/vp+sIKCL5lLBCV/RD1rpzsTFD66cwJTvZmVPse0hi1dqAyLbFZLCNxHGzcsrwZwZCCOpdnOdawn+7DSlxMN/dUJpFdl2kJ46a1nRoq8yP4uT2aNThfVtvaHSuenheEGVNivkgdTtJTVu5/gkrmXkNLs+joAtuel8HCBQBVcDS2XbjkVOFJbOCxBRAhmj35eNb7/K2NibLN73CxNdmxGz7K1TDfhOQq5Wte3kPFIufjhxpwNN2K8SqyZDVCSiutDcmB7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(39860400002)(376002)(396003)(86362001)(478600001)(6506007)(6666004)(52116002)(36756003)(41300700001)(26005)(6512007)(9686003)(186003)(1076003)(6486002)(966005)(83380400001)(5660300002)(66556008)(8676002)(2906002)(4326008)(316002)(6916009)(66476007)(38100700002)(38350700002)(44832011)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jl0DosbOPk1beo12JdTSC2U+erpGDE1EPjE7OYdAKnI3X06r9yFcJrn7OrLa?=
 =?us-ascii?Q?+Lc3Q3nXm9gWpOE+jT6JThk2kY/fq2m81b7NSy3sCs2qSvTmIAvdm9EhXah9?=
 =?us-ascii?Q?F7yRwkzE7jIZ/S6iXy2S7+eNQBKU8GZYhtbZQDvgvRtKmvim4xgc7CJ6OCCA?=
 =?us-ascii?Q?XCFY8xhNdzzcKVlL4stRo/r6r96YaQeehpf1Y8K32Bo2DyRiihGQE4js4weL?=
 =?us-ascii?Q?TDTYWtLZUFhLH76+BRPplA6YLwJRKzVU0XoL07jC7fzNS+7Aux77C3NGfx+h?=
 =?us-ascii?Q?UcJMcM8yyLGKhgRglcemok5rpwBcltBNBcTcXksXSDv2Kx4JZayWCZ245Ks0?=
 =?us-ascii?Q?7unbMk8/jXytQF5FFeGD9BZYXtXa9kTx7+KMWhfrKQrpou2oovBJpZJ5ARe2?=
 =?us-ascii?Q?Od+VrBhfA9SvS85yZcCDJcw2IP+dOJdsUc2//lD30egVVmWt/hqMi/0oxuQc?=
 =?us-ascii?Q?05feM78GSdHDUy6OwueOHgLIs8yOcLRBA8iOwFOK0EBrZW4kjhXgS6nXEPwI?=
 =?us-ascii?Q?jRKrNkN/jLpvCROmoXkh6KPl96eiCU547+4N9c396CUm6ogVQdfvlTIUzl8N?=
 =?us-ascii?Q?gGZZM5fASqIkLYsM1WUlLyg+NdDWbilOVoSXKpKJL2+1b2p8WlCFmocY0a6Y?=
 =?us-ascii?Q?AkuVRCaO4LGhFkeN/9EyEx1pXpAb1VlyzyNF4Aphdsl8pR06chF1DmULM80I?=
 =?us-ascii?Q?NTbZiREX7Hnx8JoOeXSfptF1yDgvrTOFGptpkLeNDbW2fkPnCD+EXcTXyS0F?=
 =?us-ascii?Q?j5XSFl9j69e6bgH8pyczh8eLQ9icvC0qHZ5atp0D/qHQnm5aqRtPoY6ahkN2?=
 =?us-ascii?Q?eBxJFnACKmz61T3ZT1Ez1IejxUVLQdYyh+grVLxIOa1lDOFvqdG0zUY0+8Jk?=
 =?us-ascii?Q?3OGytrPtnY86HQrnQCxTPtL5mbZPdXbPKif+qiEm4x43t5BBnc0KqrqWCIGG?=
 =?us-ascii?Q?ai3whc09eBqdFOyKq1w4A8DX2+ykaL7qqasQI4WbDuPlnkyX2ofs5qw47G2L?=
 =?us-ascii?Q?Sa9yZfmrZ/idY6yOiHB/hySBMRlh97gdTNmqspYs4SCAcCsk+JSAdybbICC+?=
 =?us-ascii?Q?F2GyeJQFKTR5rMIA/wuzL/QJoGinq9dIhcokPqYzCmKHOFBqcMq4jgcla1zz?=
 =?us-ascii?Q?OC0JebIOFgzMLaum8IhVey7N2O1CgsD4SCyy53HM7SUAXx03ucmw+nHWT37w?=
 =?us-ascii?Q?+x/JxLc5M244WZWkmgo8zk+bbS4cMf/TJng79V4qtyC5D9ijpYwLFlqK3StC?=
 =?us-ascii?Q?juxdhoey4rLjaJJE2bsLs2tZzads/yTSLwIEnJ6sUvaJ8SG1+Mm1BEJTqNWA?=
 =?us-ascii?Q?eUo4WaRDcLd2B8fcSf/54vf/0KM52NcriYqAVo4inKlIm/ZKjCrkvl1oQQFO?=
 =?us-ascii?Q?EGoUF9teA/y2mmkUxYqW1oNZdZ4eqARgY5KFd6EDtigNdOeRBQlOeWhhKwXs?=
 =?us-ascii?Q?fNu88fp1L2KO6DDM+7o9P+UWCzefuwVjaGGIS0tls7g5XrIJakjprIglouvC?=
 =?us-ascii?Q?OUsE/QosDqAlJIqrejqM8OzRuKwHv6P5r0f5RWbx7HHKJ4Ju0pWMOnRfJORe?=
 =?us-ascii?Q?zsOCkE9paUU9CpTxbVUA1/XCZcdTSLQwMC3LNxCeFbccy2uj0WWpJiWqML3x?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SoGErUusjohUFQCgsbggLgieXecpNuUcA6vKwEeZkBY1MY2xPUIpzudCAJtF?=
 =?us-ascii?Q?theAvhQ9x5Suy/56ONvWtsKPV1Q8x0laXM0WKqI9a6dtT4u2TeUXQJJjE4/5?=
 =?us-ascii?Q?kbHwi4rOySlBGcx8kRCTtOrUK362YMdBm1icaylDTCuH62dlwvFDKm84bld+?=
 =?us-ascii?Q?z0/BeijlsB+uYulKjfFjzWgA0h9xp4+HO+XUjn3EflYkGzKRRg4a2Jnxk80K?=
 =?us-ascii?Q?uSnIwSFo4v6QOrXXZWDb30FC+E/5xS2SVc7QwvjCKPWMZN1vG+dx0hOAyjVO?=
 =?us-ascii?Q?qsMJlRYtZKRVadR1Fe5MfTLg80YXE5ST1hkbMHixA2XA4Mg0sX0hxYTnx4hm?=
 =?us-ascii?Q?mhn7qFStsohvBuAQgijuiL/3GbzQEQz3r/YN4LTqM4seT5gLE5fsHxxCcv3J?=
 =?us-ascii?Q?73DQda570d9DudLOas1WR6Y9aTCD1BQbu47H6okjsbGdVn5FCFb2/UavjbHZ?=
 =?us-ascii?Q?Z5S3ek4vp9E1ukcZt2S+lOZNEdNyCQ59o1+6c0KTjQ7cAAsP00gC+ADbI0e/?=
 =?us-ascii?Q?iBZMAsfo+qglnpt7yNWOiyvzDl88KiW90u76ElKfuHoHSWK8LR9Gm/ivyafJ?=
 =?us-ascii?Q?YdXjfO+3fxj/mTjWiesb/I+8Ermo1Vg+Z8oIRus2wA4GctPn/P3Wy65Tlbt5?=
 =?us-ascii?Q?QWj8afA7tTnzrmzJgORxR8+7wnhXPkiM8XxXDWS1g+UE6cwLjtUr5iiKe2q1?=
 =?us-ascii?Q?2Do9zsWkxVr4wHL/YZl6u6xoAVd9GzQ4XnJznNCuRYrgDMHKmbwcgcFZwpIC?=
 =?us-ascii?Q?eX+5pSnshiali6c2IKfSwCqtGEYHFI3BysQqPvkrCIJxLMpgJnYjqbI9X/u6?=
 =?us-ascii?Q?QKu+0DTFTGXHRNw+i2PJ0xBUQG3gcdkwKYB0OxicLmfPEwN6qCs4MdIeWEkJ?=
 =?us-ascii?Q?g+lIfsPLChkrzWJh2zBv4Wt5uFsWr6hh3TNJb1/ikZTETg//avWTr0/fyQS/?=
 =?us-ascii?Q?ec/F1x88mtnr8yv2uQlUtNR791l5DYRE1azg22bIbR4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ffd2b1-cdf6-4900-3302-08da80359423
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 09:48:03.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf3UXdmdghdHvC8dfcoebFu3K4NaNySJ1NK+T3C8WhpSBbP9KRNgNiin398PaBuhmI9jbX/7/0DIRiUAu/SjNeEu09kY8oxs2hgO8dR7Grs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170038
X-Proofpoint-GUID: Cz6Bc8h40ZPfq9T4Z6ANdYZArJpA5R93
X-Proofpoint-ORIG-GUID: Cz6Bc8h40ZPfq9T4Z6ANdYZArJpA5R93
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-6.1
head:   6256547352fa21356de8d26b058e50d719ecc0d2
commit: 4e6bedd3c396014ba70de2b4c9995c8e024e82b3 [3/22] ASoC: codecs: add support for the TI SRC4392 codec
config: arm-randconfig-m031-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170317.bCGqTwpU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/soc/codecs/src4xxx.c:288 src4xxx_hw_params() error: uninitialized symbol 'pj'.
sound/soc/codecs/src4xxx.c:293 src4xxx_hw_params() error: uninitialized symbol 'jd'.
sound/soc/codecs/src4xxx.c:298 src4xxx_hw_params() error: uninitialized symbol 'd'.

vim +/pj +288 sound/soc/codecs/src4xxx.c

4e6bedd3c396014 Matt Flax 2022-08-10  216  static int src4xxx_hw_params(struct snd_pcm_substream *substream,
4e6bedd3c396014 Matt Flax 2022-08-10  217  			struct snd_pcm_hw_params *params,
4e6bedd3c396014 Matt Flax 2022-08-10  218  			struct snd_soc_dai *dai)
4e6bedd3c396014 Matt Flax 2022-08-10  219  {
4e6bedd3c396014 Matt Flax 2022-08-10  220  	struct snd_soc_component *component = dai->component;
4e6bedd3c396014 Matt Flax 2022-08-10  221  	struct src4xxx *src4xxx = snd_soc_component_get_drvdata(component);
4e6bedd3c396014 Matt Flax 2022-08-10  222  	unsigned int mclk_div;
4e6bedd3c396014 Matt Flax 2022-08-10  223  	int val, pj, jd, d;
4e6bedd3c396014 Matt Flax 2022-08-10  224  	int reg;
4e6bedd3c396014 Matt Flax 2022-08-10  225  	int ret;
4e6bedd3c396014 Matt Flax 2022-08-10  226  
4e6bedd3c396014 Matt Flax 2022-08-10  227  	switch (dai->id) {
4e6bedd3c396014 Matt Flax 2022-08-10  228  	case SRC4XXX_PORTB:
4e6bedd3c396014 Matt Flax 2022-08-10  229  		reg = SRC4XXX_PORTB_CTL_06;
4e6bedd3c396014 Matt Flax 2022-08-10  230  		break;
4e6bedd3c396014 Matt Flax 2022-08-10  231  	default:
4e6bedd3c396014 Matt Flax 2022-08-10  232  		reg = SRC4XXX_PORTA_CTL_04;
4e6bedd3c396014 Matt Flax 2022-08-10  233  		break;
4e6bedd3c396014 Matt Flax 2022-08-10  234  	}
4e6bedd3c396014 Matt Flax 2022-08-10  235  
4e6bedd3c396014 Matt Flax 2022-08-10  236  	if (src4xxx->master[dai->id]) {
4e6bedd3c396014 Matt Flax 2022-08-10  237  		mclk_div = src4xxx->mclk_hz/params_rate(params);
4e6bedd3c396014 Matt Flax 2022-08-10  238  		if (src4xxx->mclk_hz != mclk_div*params_rate(params)) {
4e6bedd3c396014 Matt Flax 2022-08-10  239  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  240  				"mclk %d / rate %d has a remainder.\n",
4e6bedd3c396014 Matt Flax 2022-08-10  241  				src4xxx->mclk_hz, params_rate(params));
4e6bedd3c396014 Matt Flax 2022-08-10  242  			return -EINVAL;
4e6bedd3c396014 Matt Flax 2022-08-10  243  		}
4e6bedd3c396014 Matt Flax 2022-08-10  244  
4e6bedd3c396014 Matt Flax 2022-08-10  245  		val = ((int)mclk_div - 128) / 128;
4e6bedd3c396014 Matt Flax 2022-08-10  246  		if ((val < 0) | (val > 3)) {
4e6bedd3c396014 Matt Flax 2022-08-10  247  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  248  				"div register setting %d is out of range\n",
4e6bedd3c396014 Matt Flax 2022-08-10  249  				val);
4e6bedd3c396014 Matt Flax 2022-08-10  250  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  251  				"unsupported sample rate %d Hz for the master clock of %d Hz\n",
4e6bedd3c396014 Matt Flax 2022-08-10  252  				params_rate(params), src4xxx->mclk_hz);
4e6bedd3c396014 Matt Flax 2022-08-10  253  			return -EINVAL;
4e6bedd3c396014 Matt Flax 2022-08-10  254  		}
4e6bedd3c396014 Matt Flax 2022-08-10  255  
4e6bedd3c396014 Matt Flax 2022-08-10  256  		/* set the TX DIV */
4e6bedd3c396014 Matt Flax 2022-08-10  257  		ret = regmap_update_bits(src4xxx->regmap,
4e6bedd3c396014 Matt Flax 2022-08-10  258  			SRC4XXX_TX_CTL_07, SRC4XXX_TX_MCLK_DIV_MASK,
4e6bedd3c396014 Matt Flax 2022-08-10  259  			val<<SRC4XXX_TX_MCLK_DIV_SHIFT);
4e6bedd3c396014 Matt Flax 2022-08-10  260  		if (ret) {
4e6bedd3c396014 Matt Flax 2022-08-10  261  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  262  				"Couldn't set the TX's div register to %d << %d = 0x%x\n",
4e6bedd3c396014 Matt Flax 2022-08-10  263  				val, SRC4XXX_TX_MCLK_DIV_SHIFT,
4e6bedd3c396014 Matt Flax 2022-08-10  264  				val<<SRC4XXX_TX_MCLK_DIV_SHIFT);
4e6bedd3c396014 Matt Flax 2022-08-10  265  			return ret;
4e6bedd3c396014 Matt Flax 2022-08-10  266  		}
4e6bedd3c396014 Matt Flax 2022-08-10  267  
4e6bedd3c396014 Matt Flax 2022-08-10  268  		/* set the PLL for the digital receiver */
4e6bedd3c396014 Matt Flax 2022-08-10  269  		switch (src4xxx->mclk_hz) {
4e6bedd3c396014 Matt Flax 2022-08-10  270  		case 24576000:
4e6bedd3c396014 Matt Flax 2022-08-10  271  			pj = 0x22;
4e6bedd3c396014 Matt Flax 2022-08-10  272  			jd = 0x00;
4e6bedd3c396014 Matt Flax 2022-08-10  273  			d = 0x00;
4e6bedd3c396014 Matt Flax 2022-08-10  274  			break;
4e6bedd3c396014 Matt Flax 2022-08-10  275  		case 22579200:
4e6bedd3c396014 Matt Flax 2022-08-10  276  			pj = 0x22;
4e6bedd3c396014 Matt Flax 2022-08-10  277  			jd = 0x1b;
4e6bedd3c396014 Matt Flax 2022-08-10  278  			d = 0xa3;
4e6bedd3c396014 Matt Flax 2022-08-10  279  			break;
4e6bedd3c396014 Matt Flax 2022-08-10  280  		default:
4e6bedd3c396014 Matt Flax 2022-08-10  281  			/* don't error out here,
4e6bedd3c396014 Matt Flax 2022-08-10  282  			 * other parts of the chip are still functional
4e6bedd3c396014 Matt Flax 2022-08-10  283  			 */
4e6bedd3c396014 Matt Flax 2022-08-10  284  			dev_info(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  285  				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
4e6bedd3c396014 Matt Flax 2022-08-10  286  			break;

Not initialized on this path.

4e6bedd3c396014 Matt Flax 2022-08-10  287  		}
4e6bedd3c396014 Matt Flax 2022-08-10 @288  		ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
4e6bedd3c396014 Matt Flax 2022-08-10  289  		if (ret < 0)
4e6bedd3c396014 Matt Flax 2022-08-10  290  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  291  				"Failed to update PLL register 0x%x\n",
4e6bedd3c396014 Matt Flax 2022-08-10  292  				SRC4XXX_RCV_PLL_0F);
4e6bedd3c396014 Matt Flax 2022-08-10 @293  		ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_10, jd);
4e6bedd3c396014 Matt Flax 2022-08-10  294  		if (ret < 0)
4e6bedd3c396014 Matt Flax 2022-08-10  295  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  296  				"Failed to update PLL register 0x%x\n",
4e6bedd3c396014 Matt Flax 2022-08-10  297  				SRC4XXX_RCV_PLL_10);
4e6bedd3c396014 Matt Flax 2022-08-10 @298  		ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
4e6bedd3c396014 Matt Flax 2022-08-10  299  		if (ret < 0)
4e6bedd3c396014 Matt Flax 2022-08-10  300  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  301  				"Failed to update PLL register 0x%x\n",
4e6bedd3c396014 Matt Flax 2022-08-10  302  				SRC4XXX_RCV_PLL_11);
4e6bedd3c396014 Matt Flax 2022-08-10  303  
4e6bedd3c396014 Matt Flax 2022-08-10  304  		ret = regmap_update_bits(src4xxx->regmap,
4e6bedd3c396014 Matt Flax 2022-08-10  305  			SRC4XXX_TX_CTL_07, SRC4XXX_TX_MCLK_DIV_MASK,
4e6bedd3c396014 Matt Flax 2022-08-10  306  			val<<SRC4XXX_TX_MCLK_DIV_SHIFT);
4e6bedd3c396014 Matt Flax 2022-08-10  307  		if (ret < 0) {
4e6bedd3c396014 Matt Flax 2022-08-10  308  			dev_err(component->dev,
4e6bedd3c396014 Matt Flax 2022-08-10  309  				"Couldn't set the TX's div register to %d << %d = 0x%x\n",
4e6bedd3c396014 Matt Flax 2022-08-10  310  				val, SRC4XXX_TX_MCLK_DIV_SHIFT,
4e6bedd3c396014 Matt Flax 2022-08-10  311  				val<<SRC4XXX_TX_MCLK_DIV_SHIFT);
4e6bedd3c396014 Matt Flax 2022-08-10  312  			return ret;
4e6bedd3c396014 Matt Flax 2022-08-10  313  		}
4e6bedd3c396014 Matt Flax 2022-08-10  314  
4e6bedd3c396014 Matt Flax 2022-08-10  315  		return regmap_update_bits(src4xxx->regmap, reg,
4e6bedd3c396014 Matt Flax 2022-08-10  316  					SRC4XXX_MCLK_DIV_MASK, val);
4e6bedd3c396014 Matt Flax 2022-08-10  317  	} else {
4e6bedd3c396014 Matt Flax 2022-08-10  318  		dev_info(dai->dev, "not setting up MCLK as not master\n");
4e6bedd3c396014 Matt Flax 2022-08-10  319  	}
4e6bedd3c396014 Matt Flax 2022-08-10  320  
4e6bedd3c396014 Matt Flax 2022-08-10  321  	return 0;
4e6bedd3c396014 Matt Flax 2022-08-10  322  };

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

