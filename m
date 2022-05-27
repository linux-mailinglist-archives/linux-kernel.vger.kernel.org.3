Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C35535C91
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350618AbiE0JFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351196AbiE0JBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:01:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FFD132754
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:58:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R5Fl5F019648;
        Fri, 27 May 2022 08:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zOqBbiYCpHfJhYl1156KMTvQBRt12m5V6fmW55WgTqs=;
 b=S9y6vhdEDudYQdeSm3WKknXTvnuZUCHOnGtaGSAIqp0pKZVljPjcSEmKsXX3bSPG2q0o
 VzjQPkXQV/a6Le8gfsv8Yx62+RgSmEArs9z0CaMGSBEaHCFxN4pX4hig5apRmk4lmX+5
 tIMjnaJSIgENv1zk3rWtrohIH/DzVip8PauGoC0JZqMpEb61XZYhF3rtwKI/8YGaBT6k
 W7HscUFuvvIG4qBXizqdTyqFqAhyR3YtPFNiRqGpL9LmbjPWD0eDZK3GmHB4diOpdicu
 ASZUkIs2wGVpwNN2uRrtmlUTwfjbuTWyYty+CikMkKdeEP6B1yfbDSJ02VGDtJ2s0soE ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93taxwba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:58:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24R8tjtW032256;
        Fri, 27 May 2022 08:58:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93ws8w5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 08:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFuifnrdlNiSsWZc2+Iok7PheUBAzIof/ocK4kKIM5Ao5GFynZxjxSqQyQV65s02R5AFaf3BP5h9cnpOa8PAPQAcI4IiqXWW2LQ5anWteuQofQcjcEaIJsFx5i4Frc2CeRCm8DeDwhEWMWPI/fS0tQLsr1yW2eGL9W6bN4lZV+orjWmWuqq3x5Auv+v7dlg3PdMQqgz4HZw5IIH8vbgSLrQNSspDIpO75w2FYTLgwGDDY/YNm0Dnd3ebrDKsLgwHGZdJ2EmvNXWMbAV1kRjWWFEw4LPqx96NS77gyTsAYUFxwd8xW8LocQkHrJ3Sz4/uJvgyV5sP+yUR8v6NQ+Knjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOqBbiYCpHfJhYl1156KMTvQBRt12m5V6fmW55WgTqs=;
 b=januodQUIvMiMPZiBkX1M8hi444pKf5hPYwIVNHlYTmPW1AztWo/DoANW93r7+c5LFGW53rj0da6o6c4pHjcIpUbdWDVdXX1LMMwMmZzrdtYlPWPJqpkX5I7M+OE8b7IC2zcKmrxEDXlMk/ICTYdlDU9GC7SQexn8synEMT7YDECXy9bqif06SAGR0nAygdKPFpGT/oGZ2c7hcA/aIpWaQxDaUPctse81jYrq4WJ/uxeMfPzeqEMKK8l/CZFlfv+QIkrKqT5V1ETawzdCmpBP6mY2qVEvBOfs8zmpXpAusUxAUH8IY4sciZqFd+08tfOWFeq5KtV8syGfHDdqMKncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOqBbiYCpHfJhYl1156KMTvQBRt12m5V6fmW55WgTqs=;
 b=b17mmXRQ0CC6bPy+hb1BjS+GpfbQ1VVRz2zRmtoy0Zo/XMxa/29XwcVSZB/RujWKRNhDBGVlW/hm/kdr8oR7pAPD0u+35sTTPz4J6jwJVREuGYZFB6yEHnEd0ItfqTK4awkuo5AX7WyLw5aiRrW1TeYSe3tvj3KyNPzAq2Gr5nA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5344.namprd10.prod.outlook.com
 (2603:10b6:5:3ab::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 08:58:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 08:58:01 +0000
Date:   Fri, 27 May 2022 11:57:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Cristian Marussi <cristian.marussi@arm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [kbuild] drivers/firmware/arm_scmi/clock.c:242:40: warning: Variable
 'msg' is not assigned a value. [unassignedVariable]
Message-ID: <202205271608.aIWtyM7b-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: O7XO5LN5MGS553UDRGARORUIGUD4XR3O
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0064aeb8-8a27-402d-0d3c-08da3fbf00b7
X-MS-TrafficTypeDiagnostic: DS7PR10MB5344:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5344B3CD25B0123FF05D2A808ED89@DS7PR10MB5344.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pN0Y8ucP6WtDYmuzf8cABimtotvY3Dtz50C8lAGRz1eCoisiI+jtwoAdTn++ArFTBv355rZXcpisfdBHG87r72gCIb9IUSo1QIqHMyoguDeNgte0qz6gmRygEAM2f4JT+MMgUe7BqLt3Dkf19Mp1P39p0sdFNnow7YZrcqAIgq8/wHOC3XBUB8nsFhUd0p5oWvHr6hTV1Uw9uawbH4m7npxgGu9WjHGZSxeqDYKBecpcvoQS0kmXYeF1BH93S2/6KwEbUSbQFt6Z89v1b3ZnWa609nv9tEchQac+jIlgXY3yA6XZeQRTeR74DgvAYU5vl6oApeJ9+K53wahIxTQnAk4ef8898RC98dYSh3o3Z/x9Gv4Que7/INYreFv32w6miD8uJ2O1y7uQOmaOJZ0x/oZUoL+NuTp+cspdPldW7bA8LjbCAd5CAkJF59XNP5GBBo8a4mMwtnQ/Utg+HgC7DbWuuEpY7nrs18gj/+m6EAdMIO3jO7ZIE2hmriaJhSfTgXUs/vMashJuaJy3IeV/YKE1SxfAHTeeis7q3GUXHYCOBCxGR+3TftMtZ4KKxFtxISkQO3HAqxkJYAKcj0Yh2AIRkK5if8QZQs1B/V2Q6eOLPjh84HeBNk7+7j8+yt+9tPui/8UMNalqgTPndid/M6hzlNuN9V4Iwt9Af0sIf04As0cDa0RToh/u11JEHOcm7XSOYtUXBolZnHhNjQ2yDdQUbeFR/oZ6H9qNMG30UMSWcjoeLTmkCZkJ40yro8RCIlhY3BCa8/wn/zKeNyf9cg23QG3IBhEJMhDwi7KN2wTDuXE8XqxjfldDFpMYlicQj4FdY2eihfYASFVBoHDXXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(1076003)(316002)(36756003)(186003)(6916009)(2906002)(38100700002)(86362001)(38350700002)(52116002)(6666004)(8936002)(508600001)(66556008)(66946007)(66476007)(966005)(6486002)(8676002)(4326008)(9686003)(83380400001)(6512007)(26005)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4YG4SPEJCII1ygtl+rtzNdVzFhnrddBzPZ10dHnlZC6wnx38xfwQQnYoZLO4?=
 =?us-ascii?Q?f5aTP5vYPM2GDQzYAFWXLZ2hZJju/q32zw5YQ3c1dAKZnTGr/QKFcNeyD06E?=
 =?us-ascii?Q?6l9Uhdt+so9DDXrovutp0cILIWcqxg1+rME1oLDzg1CGB4kLYMzujejl7Wot?=
 =?us-ascii?Q?1UjlSEbxbtH0F7nU5mMSPK3ZwlmLLn4CaozjgboP5W+4YsCcZpfs6u9gcPYb?=
 =?us-ascii?Q?0UeM43Xw9Bh6FA5bUkqP+WsGRtG4lgyZeuMsHx4rF4FB2bbJ6AlymyxGB384?=
 =?us-ascii?Q?AMY75Ml1IMn9GMsd3xYimQc5mep70y7OyxS+ZSSdL5K27QVJLRKTCMnSJk86?=
 =?us-ascii?Q?TSpy7yRu1NdSXXKXRFcodPDJHFn0dhLjuEcpGeI6gFHKKVkC2urK9qvs6D6N?=
 =?us-ascii?Q?TNTCOwFdtQZ3BkhMykWEd3p6Hhw8W8SA54bPqyjupGs0NKd7xNjZ8GyBJT5H?=
 =?us-ascii?Q?Zw0g4qbhV9bNAGgzBDA4hAHlAOwf6SphVbz6xp4d4IK4kbpjfzO59fKlBS0y?=
 =?us-ascii?Q?y0pcyQ3iIxfmuGefxvgY4icnNNOxbfs5+W0t8Bxh+4VHo0dD1GEESQvOhjcW?=
 =?us-ascii?Q?1vxVHtYytVOKkdwqnPjRfPDAbF2CaRVDdN/ubmDbSSxF+YXZJmCKCnLNEznr?=
 =?us-ascii?Q?mPx+Yj+4QyK/JCimE8wFp64tSi8p9BdQ8A+kyFf3B44VdbeA31Eq9V+zrmVn?=
 =?us-ascii?Q?r8Z+Yaq/+30DltaRhjvU5GAHbqUSZp8V3wkYHqZkn/QqOShOOh1aC4GKuj3Q?=
 =?us-ascii?Q?ZGOF9RyrysiaHAB03b0rgQKe3K3RS4mgK//Ca/slL5nZNIYcYBCd6JvDHgnD?=
 =?us-ascii?Q?/6DK+UG3YMJwE1tbsrLy9jZDeUxCWAVFqDOs4F7R4ebZV9cV6xzjAotdsnDF?=
 =?us-ascii?Q?Jpxgrrp3SgsMq7u8y74MhJMCtcyt6Mqg3nAdDkUperbOxi1qCx1T3gOzh4jU?=
 =?us-ascii?Q?zJUQgMDyuu8SoLXTqV2vj1t++5XDf9SRxa3zEtS+IHurvwflQaHl03Ed7yiI?=
 =?us-ascii?Q?k4ndv8Cc4Rx6FnpKbY8t+c7tkYqBg94GMT1eiqo8bE7HuR0vIKwr+2QPrKh7?=
 =?us-ascii?Q?9AIi5gU5gQEEKHgXnaM5JBT1rMfEacheswyiCouDAaEcBSLJJbrGW/yeLQSA?=
 =?us-ascii?Q?7WRmymuE0a/PoeLqxghmNLMZeBmlxsjJQhjSkziA45lVKbj867HIjSN6Nlow?=
 =?us-ascii?Q?8h8F8UxSC8DzqbYjh/SGBJ2zQeAa7mCiGMtrWYL/fn5GyQHLXFCPXPYBaUsS?=
 =?us-ascii?Q?YI7nyuPDdkgsQ4zbxmDHluq6mCQvET/0P2kvEA+2q+dEpg0H6P1l+6+u3ft8?=
 =?us-ascii?Q?mo6IiP5pHYRPVlqUB5pfRWxNY9bRU/quIiI8fguDPuKoV0RBeKC41htpsFlI?=
 =?us-ascii?Q?2TiER1akPMf2iYc3rAbfbUbMAhDLGB55sOHL49kIVBtrctivBfyyZccOQ7ZM?=
 =?us-ascii?Q?5uFHr1EompgqecT0Drt0JYIXE54wP0G252fpbe2kglctN7x9wEVeO/nqymZR?=
 =?us-ascii?Q?X4oFr/6tSmexaSs9vVhziQ2Wj5ZCJlspvglElw5cqcupEGdlE+/4zjjV9FuA?=
 =?us-ascii?Q?Hceh1fzf09TX/RFFX5ZCLq92eiVWNl06GfQV9UfHoMLPyCeukD7vyjrbCJEa?=
 =?us-ascii?Q?36O+r8jX2o6iQmxjrnGEza0A9VmOqJJ3+/GO4rLr7LzN9Pbyu14MYXc5Ruze?=
 =?us-ascii?Q?VcqRpjNkx8NSQ6i9QH0fB1PG07BMxeQvByjnu5+FhGzyZZAcINiGHyK3gAgM?=
 =?us-ascii?Q?8N1qFKxqCWAbqtnKxQpcXKdFvoYA7TU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0064aeb8-8a27-402d-0d3c-08da3fbf00b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 08:58:01.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2dK/qoIJvOTdnFWL5EgD4YiwXWK1SZFniivaqN+hi3or/sWjID1hsYUBF9raA7OfSqhr+A8w2juQ1PokDP16TSZX0sJWvj96cZuSzKChRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5344
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_03:2022-05-25,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270041
X-Proofpoint-GUID: 58A34uhQGuhNTLatt-8CX-vNqdbgzcM3
X-Proofpoint-ORIG-GUID: 58A34uhQGuhNTLatt-8CX-vNqdbgzcM3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 7bc7caafe6b1e5b882255a42bc1bf112fa87b69b firmware: arm_scmi: Use common iterators in the clock protocol
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 7bc7caafe6b1e5b882255a42bc1bf112fa87b69b
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/firmware/arm_scmi/clock.c:242:40: warning: Variable 'msg' is not assigned a value. [unassignedVariable]
    struct scmi_msg_clock_describe_rates *msg;
                                          ^

vim +/msg +242 drivers/firmware/arm_scmi/clock.c

7bc7caafe6b1e5 Cristian Marussi 2022-03-30  235  static int
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  236  scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  237  			      struct scmi_clock_info *clk)
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  238  {
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  239  	int ret;
5f6c6430e904d2 Sudeep Holla     2017-06-06  240  

Please delete the blank line.

7bc7caafe6b1e5 Cristian Marussi 2022-03-30  241  	void *iter;
7bc7caafe6b1e5 Cristian Marussi 2022-03-30 @242  	struct scmi_msg_clock_describe_rates *msg;

I was so surprised that GCC doesn't warn about this but "msg" is only
used to calculate the sizeof(*msg).

7bc7caafe6b1e5 Cristian Marussi 2022-03-30  243  	struct scmi_iterator_ops ops = {
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  244  		.prepare_message = iter_clk_describe_prepare_message,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  245  		.update_state = iter_clk_describe_update_state,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  246  		.process_response = iter_clk_describe_process_response,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  247  	};
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  248  	struct scmi_clk_ipriv cpriv = {
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  249  		.clk_id = clk_id,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  250  		.clk = clk,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  251  	};
5f6c6430e904d2 Sudeep Holla     2017-06-06  252  
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  253  	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_RATES,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  254  					    CLOCK_DESCRIBE_RATES,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  255  					    sizeof(*msg), &cpriv);
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  256  	if (IS_ERR(iter))
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  257  		return PTR_ERR(iter);
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  258  
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  259  	ret = ph->hops->iter_response_run(iter);
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  260  	if (ret)
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  261  		return ret;
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  262  
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  263  	if (!clk->rate_discrete) {
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  264  		dev_dbg(ph->dev, "Min %llu Max %llu Step %llu Hz\n",
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  265  			clk->range.min_rate, clk->range.max_rate,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  266  			clk->range.step_size);
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  267  	} else if (clk->list.num_rates) {
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  268  		sort(clk->list.rates, clk->list.num_rates,
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  269  		     sizeof(clk->list.rates[0]), rate_cmp_func, NULL);
7bc7caafe6b1e5 Cristian Marussi 2022-03-30  270  	}
c0759b9b5d411a Peng Fan         2019-05-22  271  
5f6c6430e904d2 Sudeep Holla     2017-06-06  272  	return ret;
5f6c6430e904d2 Sudeep Holla     2017-06-06  273  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

