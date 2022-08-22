Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071D559BB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiHVI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiHVI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:28:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B5FE0C1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:27:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M7xu3L018866;
        Mon, 22 Aug 2022 08:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=VN3rV3WtuhaCYDcgnYraSf3+4vsucGsTie2hShaZgL4=;
 b=C7zUaesVsTpwHukvUkVNWq18UlPPFzaBAeY1LownLt8l3iRF8lmAm/1NMHhhHQhLXQG0
 VJUsSzWL5g52WOixkKgVxwZYd9R+Cywkg2+/zv7Yik09C/cC2F6F+V8ahyuuJvBiFrxK
 8p2/oo+0Si3bmXA88VldA+ugNZyKO1v/Qb0e4i93uqj1ZaqcAE1fqv3Z2P0TBBnhZ8B9
 oqAKJ8vUsoxC25zeUn+uupNp2xGDDeBvHXJ+QjWEdhB0bShSq3m2Buco5oosP3nARVTH
 6orXDx+OhO6pAnMsSWcCIES+agibbWM6SBDY53WtfNuJHN533t7SHtvNrrTaggZYGxDu Tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j45wbg2qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:27:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M5rfAf038322;
        Mon, 22 Aug 2022 08:27:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkfrrkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 08:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTlpDyYJPX/i0YgUspJSrDzFPxRdrOziAVyOrFadNFUIbrnOud7SuZcP2/+ze2YFeFSqbET94FuDZwhofNjG+APhFrqeJhwNKIJLa+6eljTcJ4X6PwrlSeFzIdULEnMd700TFoohDic/sF6ouumh65vpI2wtLAvlxoPm1I20NUcMzdiIqodPoXZWudYWyTnvWkvMRowyAzf0BHcJUdn9HrnQZDCjakv5p+wVmNv1ewDztwj5jJFw4LkoFcSI6GJqoG+lQbZ2fFIGD6u2KG1Hom8ZeEgeKf0HkCfZ7SBuT9MmTyt6SlRhfcndCGBoPdKHgG9dju27loQJ6dxpKh7sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN3rV3WtuhaCYDcgnYraSf3+4vsucGsTie2hShaZgL4=;
 b=f4OWlEI/XbJRhJydM20RKuHRqxAF04IATWbsrzdWMGhtKBQbFbO9kherp2C7/40XK8LsojhaB41C9UTxaGB7bZI5YKRyRRXbcKbOGx4KBUWqUgVLOLsOaY1gRm2SxFH4noZWod79aswETNkpI59UAAL33pGyIjRez71YQUbrJgx9SrM1B9eL7lDo/VKCVuQpuTMU7CWy30aagfiFO1Hw08k5tTWCrzmN4iuO3Fs0aIvpTbYvn/JIFtOE3g6Kxfb3HqgN4drod9ThHgCu2ESbP+mvW2huOKiPxfOskaZ5+xPI/W0VkFd1QglL/J8H0ydM0idJjiGyu2lD/hW4S5BjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN3rV3WtuhaCYDcgnYraSf3+4vsucGsTie2hShaZgL4=;
 b=DjH8zukTCSX1b8P2GoNDz9UtiyL7X8ExjEh7HAxjHGMiwsDnOjZhooJCZ+0otDuI1ZqAn9Jsq/+K5SyeWIATDAxWOv5Q5oCF7NMcsPyDiFx9+ycQ+bke1o8diGY1gjKiazZrLS6TWBtaurWLVAjA9Wgwc8+6M/tohdAfMHl6NVw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4903.namprd10.prod.outlook.com
 (2603:10b6:408:122::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 08:27:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:27:43 +0000
Date:   Mon, 22 Aug 2022 11:27:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mia Lin <mimi05633@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: drivers/rtc/rtc-nct3018y.c:112 nct3018y_get_alarm_mode() error: we
 previously assumed 'alarm_enable' could be null (see line 96)
Message-ID: <202208211110.jFk2KTL5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f4db844-62f3-46c5-6270-08da84182ee9
X-MS-TrafficTypeDiagnostic: BN0PR10MB4903:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7jPdd5dNlx6KUoug1yxfFeXNespYYODGokKX9GvIt4JlMwxgAd+L4sukTmuh1hVFCZU4Z65pzy5/j7nxoHnKtaUmEaK4cEHUPKqDJQf5I41o6B35996L0+3L4daEE5B9clr1XJ0w4fAYVyBeJchgVWXFFwtFC8Czs2KWvg11h0kB3XmiB4ycbgI8WCA+dHqghTi5pUz2aSw+Iqr+86Ak+0+nd71HU/5XAREhS1fwTr+pvewcc+7KKhSf8RjOgPYdxSAVUKyJbQ7wz+vgFfmOodZuNUwrSLYXnCrt9LDdFUhx/pQTL7FD1RHqpdbTmQ3ANoqELvHwRSrWRe+R7YVevSD8MB2T/OHl9vGp6Nd4fvyEa87iKqP1fgiFg3v7czyEqNllZAWzqYl0fl6DQwPIz9ytQyuDp7C63czlaki4srk2BLs+xTsd7YFyT0lOl87T296Y246plgzFcu+Sk2VePbUQPxc2FPSNDB12/ZBrSdXZrqzzWBWVy3PoTGTjzYIi3DpwjYmYy8ii2TV+eMV7DqzPe3nqSZatt9Hz71W8Ql8v4/hL7w+AhWN5vrUS0xlbmTUUe6ITx2wkKoMXBpQMnbhluVOLEWHxpxSxyG40mYEZLBqMvW50VudhOD2UQ8Kk6UMse8+sUWb6LmhbbYH37iZrxMSa6GH63RFAZZcYNNftfHhL+CO9A3S3l2/JbEvDgY2KBD1QhqX5e67yUFYJw6JhhNxeB+JKY5GOpe8ugEfcDOFKQDYmgYN9FqLxYL5O+lzF6OLWUVJvrprnwX8vh8qO9UvNqc6I89msiSk6sBXIcweIdQiuDZf++3K5lmwkjH0/0KmYOeM72s8PoEtyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(396003)(376002)(41300700001)(6666004)(6506007)(966005)(6486002)(478600001)(1076003)(9686003)(52116002)(6512007)(26005)(83380400001)(2906002)(5660300002)(44832011)(186003)(8936002)(316002)(6916009)(8676002)(66476007)(66556008)(4326008)(38100700002)(38350700002)(86362001)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lRsm/h1+f/2GN7jgD/N07XSOOs2g7U50cvqB3jwM4eI7Y1+QrnH+tqeNd3G?=
 =?us-ascii?Q?C3QCDYxMEK8gRXscegRYEuyy+HR0HY06ERjgt7ckSDarQHGZkahpL5wCceaj?=
 =?us-ascii?Q?9/h483M2dutE/wYSV92lLNz2EiRDP1bgsrW993925GD7qIEEzs7y+wFFs4rd?=
 =?us-ascii?Q?TDtDCVuh8fUTnCKT25ijrBPI8armN17X9Q2n6m+AJcOnZ+cATrwLD4K9nOnl?=
 =?us-ascii?Q?UYgXvM/6m/JNFRdHGg9Aq7yP3lnj284YnqSetDNff7tVEdro/GdNxnXR4G8m?=
 =?us-ascii?Q?BpoIdIDi9uzZIcaIF8S+as2Qnc5dkBhGgL83CWCANcYoxU+5ci3jmgfoZcdz?=
 =?us-ascii?Q?IpMN3RfW4a65HqXX98lYh9CwR4atErL7Dvc8+0e8PfB87JAGr//N0nezDBYd?=
 =?us-ascii?Q?ROKzRTS9qHgpOmI1fbBdgTiNR1+bATlMqYvTB8yEy1pWp1CmH7G6rhHLorma?=
 =?us-ascii?Q?ug4HVhgFugTCmpJ/dkeMKyRCoLNAeFBZSjsS6ImnyKx7aUURaacg7CbMCM9Y?=
 =?us-ascii?Q?yrMUNLrvQpOvyd4N1ff4XFQ1VPB4TRVXz1lEd5uaTDyhQYJmmMjYQYNRzyU9?=
 =?us-ascii?Q?B3ftllA0ka9L3wi8cg14yQ+donINb6Mfv+rid4Zka8asOmnLKFhHY715yiUA?=
 =?us-ascii?Q?D0Izkq4uyhq/Oo82T7lJvx1aQmJsQ7uQ0HQJ/G6WEuK0iNVO0aUIp2a5caTs?=
 =?us-ascii?Q?IQSfRLz81guvQIG6HOeELEQXeggin4UZBcekSynRvDk2wl2bpl6bUcuwEiIh?=
 =?us-ascii?Q?gbki78oRroklUcDUOiDrzFlwjOaKzNPJScNj9CpUPjtdovs2NkYmNlwaNs8U?=
 =?us-ascii?Q?fXMMqY12Yv+kxVzpxbQjZV7CWdh29cSKjKmBB+YKkhbtKhRXbhiEtqrONtr8?=
 =?us-ascii?Q?dUBI0zAXWlaumBkdXLUSz9Jo+S11wZQ3zB8M3QNbLiSUMRCsKTZt3sQkgpq4?=
 =?us-ascii?Q?/zbANO7Sn6v9ITm4atu5uy26z7+Rj6IkP58P1pTexrVg1yz7Cp5cI1RCfRwd?=
 =?us-ascii?Q?8KP+GF1NU4a6Mfqa2fTYWB0rTL0+xasdhUm8SJFz6N08PyjhkQotoN37H3L5?=
 =?us-ascii?Q?JXiH2ke0rJlbPSbtrKxil0Rl/0W6ysmc/8lUMDsdNZ4nAlb1ULPUIsicFYFF?=
 =?us-ascii?Q?bx6yVnkZY4MccH4htTu4nTap/vx4A1SZLvi+td3/IWfAWTEbqvRYibTXxu2F?=
 =?us-ascii?Q?10sS/43xbumFyfhPjMqXuuK4XpPRndpKr3Htppne9k46w3cogvjjXY//NYvW?=
 =?us-ascii?Q?kBKZgA4aUdAVl+HAFMDpqrSHduKiAXktgW3pStGADH/sR3A78g/9hY8HT2CI?=
 =?us-ascii?Q?yVYr/b2PR1btPTIwsNZf9yYX2Gq5R59chJRavWN70DAH487S86ulBqA/vw7Y?=
 =?us-ascii?Q?krczyv4J96k4Mk52dv5p0hOiavlHB0pZtQSxF1aRbph0Pz9cG2l6voF2qEgr?=
 =?us-ascii?Q?myxDGh9g4Czh2ka0bAWX1rsEjUNb7TIuz8/Fm61dKtHQghorWt69x7rpNh2K?=
 =?us-ascii?Q?ieTCXDuCHurA3Iw/1EwX82+hsLDQlC+kAeMdjxVje1YvUx2A3s3Z+WzyyX4w?=
 =?us-ascii?Q?r38BhRIFy6rGQVbclR6MvNeoKrabhCcRNviDNopSD9wtxt+CHjkLngkarLB5?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4db844-62f3-46c5-6270-08da84182ee9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:27:42.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAkFH+Y+Hr8BrA1jQAoZ1QcixkeQXszMYeI+xiiZolzWDf+AOzs8H3Qo7+/idAi2qhKu8qddBk7AK5m9v7n6x4HNr9E45kR4yV0QQOI1Two=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220035
X-Proofpoint-GUID: yxZ83kNvOZ5LunYXKmOi1QeWSf5gnXBY
X-Proofpoint-ORIG-GUID: yxZ83kNvOZ5LunYXKmOi1QeWSf5gnXBY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15b3f48a4339e3c16acf18624e2b7f60bc5e9a2c
commit: 5adbaed16cc63542057627642d2414f603f2db69 rtc: Add NCT3018Y real time clock driver
config: arm64-randconfig-m031-20220821 (https://download.01.org/0day-ci/archive/20220821/202208211110.jFk2KTL5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/rtc/rtc-nct3018y.c:112 nct3018y_get_alarm_mode() error: we previously assumed 'alarm_enable' could be null (see line 96)
drivers/rtc/rtc-nct3018y.c:112 nct3018y_get_alarm_mode() error: we previously assumed 'alarm_flag' could be null (see line 104)

vim +/alarm_enable +112 drivers/rtc/rtc-nct3018y.c

5adbaed16cc635 Mia Lin 2022-07-13   91  static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *alarm_enable,
5adbaed16cc635 Mia Lin 2022-07-13   92  				   unsigned char *alarm_flag)
5adbaed16cc635 Mia Lin 2022-07-13   93  {
5adbaed16cc635 Mia Lin 2022-07-13   94  	int flags;
5adbaed16cc635 Mia Lin 2022-07-13   95  
5adbaed16cc635 Mia Lin 2022-07-13  @96  	if (alarm_enable) {
5adbaed16cc635 Mia Lin 2022-07-13   97  		dev_dbg(&client->dev, "%s:NCT3018Y_REG_CTRL\n", __func__);
5adbaed16cc635 Mia Lin 2022-07-13   98  		flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
5adbaed16cc635 Mia Lin 2022-07-13   99  		if (flags < 0)
5adbaed16cc635 Mia Lin 2022-07-13  100  			return flags;
5adbaed16cc635 Mia Lin 2022-07-13  101  		*alarm_enable = flags & NCT3018Y_BIT_AIE;
5adbaed16cc635 Mia Lin 2022-07-13  102  	}
5adbaed16cc635 Mia Lin 2022-07-13  103  
5adbaed16cc635 Mia Lin 2022-07-13 @104  	if (alarm_flag) {
                                                    ^^^^^^^^^^
These can be NULL

5adbaed16cc635 Mia Lin 2022-07-13  105  		dev_dbg(&client->dev, "%s:NCT3018Y_REG_ST\n", __func__);
5adbaed16cc635 Mia Lin 2022-07-13  106  		flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_ST);
5adbaed16cc635 Mia Lin 2022-07-13  107  		if (flags < 0)
5adbaed16cc635 Mia Lin 2022-07-13  108  			return flags;
5adbaed16cc635 Mia Lin 2022-07-13  109  		*alarm_flag = flags & NCT3018Y_BIT_AF;
5adbaed16cc635 Mia Lin 2022-07-13  110  	}
5adbaed16cc635 Mia Lin 2022-07-13  111  
5adbaed16cc635 Mia Lin 2022-07-13 @112  	dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
5adbaed16cc635 Mia Lin 2022-07-13  113  		__func__, *alarm_enable, *alarm_flag);
                                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^
Dereferenced in debug code.

5adbaed16cc635 Mia Lin 2022-07-13  114  
5adbaed16cc635 Mia Lin 2022-07-13  115  	return 0;
5adbaed16cc635 Mia Lin 2022-07-13  116  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

