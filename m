Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEB57B420
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiGTJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGTJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:46:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05633240A0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:46:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K9Y7qQ015097;
        Wed, 20 Jul 2022 09:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=AVCU+QkzDWOKlWU7FXcA4qKN7hKBEiszNl17u313abA=;
 b=wh38qxT7n6OCfIKxBREkTnoQgWltQImXFiC5Q89XtSIlMyPhIHk2FP+yceV1yHWI/KYc
 BsGQBfmZ4SM7tPxvdwKcf1MgV0SrIs6e2UUR0dBtKCZRvpTqr0pXZuiC9t+xhF24V2kw
 qsKaiHpicmVi7J8L2wh3gqwZMBtRGAROMZX5uR3EokDBZRjkLf+18s/pO9mXdBTXAeR1
 raxXQ1hZmCHhgqwkzJoUVSM75uPK5w1LeL3jIMp0wV2zV0ocyeGN88pdSGRYxLQ4jyHg
 YuUclW7Nf7EkFxdbT+jkzBJjVrA+EepwoBo2/Ot3b1eX0Ip+Du/PjzMmcmx4YLT4sGES rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42h0re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:46:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K87YgO016395;
        Wed, 20 Jul 2022 09:46:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1enavys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR2YQwPl1iH922bsDQ2Xs251MWrwu929IFr3VPEcwHLYC0kW3VbI7ZzjEPR2NSvmkCGa1tA012Cb33Pw6YqBU0Qxs3QfFsTjd9JOR6n0eDD5Ghxb6s8Kff2yHjZYDGKu0YAAALg5bS8Z+n0Ll8+vHJfV41KYL8lPnZqQRoSgpLgtWUWbX2JalTmlQMlYCNP0TeGTYv4E/NhcRN8u0tIEYmdv8C3bbxTi3UHbhCMIX+Jjy/SL4GIVQJrgyNVlWZc8xziv+hbRCHx0h1QJBfyn1RdqpOPmHBzy8PeqZuhsIskVVUw7B5bsb34x9gfdHff9T434UeEEa+LrZUshMhIXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4mtQvEgybohIat+FndWXoibCjztbN34V0Ugj7btfds=;
 b=QK9kCejYACm7xG7KoSi9p1cCFLDsAFb4ThHqD/kmunSZMaTQo22MuySYdYRIhNKc1zRbHqYepL8jd+MW4BLlG/I1rbD91sfVX0F9XhGcni2xb9Hsq0DWJXAU+43ubJvbEafgVCjybKOjkk/hsUL+Gt9sEEvB4x7aa88wCjbBxtibk/OR3XGgRC9xOms43mlJVueyC/C2am8iEoTTGYf/0yBLM3lelXvIj10gdwVSvaGouBAKQVAm2g/V9V3IC81FoOL6tChi0nTplU7TMhetoaJ736o7+C8TQcd0+NfbcYE0Kn5MdRiM27E/Q5RTpJTeeqXdI4BXnLWrpJ6p2kJhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4mtQvEgybohIat+FndWXoibCjztbN34V0Ugj7btfds=;
 b=AqFNE9gsVlJL6rrHeUO1n23dVd2mNdOy5hoHMkNx3R/IkpBInSTYYc4zm3d85/A4ojyIbIB3iA0C1r0m4MVKlTn39dfFjrz4pAPiLKknIwI0eZxDeeK0ZyNw2+kiJRgVmgWf/OqjdlIXQZCaIe5dG2x0l3/fnW/DGheNXv32N3w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3354.namprd10.prod.outlook.com
 (2603:10b6:5:1ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 09:45:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 09:45:57 +0000
Date:   Wed, 20 Jul 2022 12:45:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dongjin Kim <tobetter@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/phy/phy_device.c:1772 phy_detach() error: we previously
 assumed 'dev' could be null (see line 1752)
Message-ID: <202207200005.1kAdinkP-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc9b298-3be7-4aae-079f-08da6a34a5a1
X-MS-TrafficTypeDiagnostic: DM6PR10MB3354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouZIsHKhqE+kmKx1FqanRNoeAUBfdLZlGXbrNIsxqKS9J6p97LOqlqAbcT0M32qxi1skCZHULF0nhzyhECLdXt79hWONOyfDNYqYpm5YmZPIVq3YgNNQn79zO7reEpO1IGU1ipvkSUbXk9EvUJ4OJM/qPpJcpU3g35p7lv8xViNxjOfghS2rMpaQklyrrc+fOJBgWagM1bICiwXGkAC4WfSX08twYfO89kELBnkG0G48fjmtClXwYnFxxVdMn+Me8gQ84J1/2ngcAwIN8Sq/z0ENPmr4Nt+XjFV/nGhhIn4TQAL0uElobfXzZlCCA3gv4tcsGEb0cAzTIQpuavtNweT4qr9FLBNabKnws/btsxZRhKMjrc8fCJYozvIUKSPLeXDJSDf5cO3soSCZM9yx4S5JKXDfgJHEBANH3p/B1z13Fq96esKEZiENSqXXXxrvrhDimDn4QWnt/AbPWQmHcFXq6GDsvE0bjPYvyJdoHFiD3R/+aFRuVosfQlyoHvk7zIbBgKTSShAjzVB2ujyA2//a4YLuhE/NFm0V0KIn6MsOQ6nblNqDKzM3HAymNPN8wJvcjhMo3vVj0FPjySPFnCkEn1F2AkXSmEJV12TzOebEbDieqDd4MozvrZ2I9SFNovD3NpOB9fSFeIhSIYbDZcj7KjP5k3aYsEQrPaSOUcEYzlMB/mSbg+2ctHGV1pwiAmlplW0habOy1rSD23ezv5W0FXZx7A+tBGyR9yE5INUjESdMJgB5BgFHa8HHIx2N+ziIiEzPJAruSSjev3RveBAG1ljsmB1mNrtLXrLGvrYeVIQn+AZHfW4QmAWz/Nt7/5MV+BA1FN2aeWFXS6xFClhjrwFced4lOEfUwuKZ47g15HpTkCIqCmd/rkDSGtM2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(136003)(376002)(86362001)(6512007)(38350700002)(44832011)(38100700002)(83380400001)(36756003)(26005)(966005)(41300700001)(186003)(6506007)(9686003)(1076003)(6666004)(52116002)(6486002)(478600001)(316002)(5660300002)(4326008)(8936002)(6916009)(4001150100001)(66574015)(2906002)(66476007)(66946007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RxMJ4rRgv+1gfWSQW1kDX2aWRyDdYGDeeFYmUClOvw40NsCZ1D8eN4vXhF?=
 =?iso-8859-1?Q?1Z9QdfBZlfGGPAJtrMIVkpL2egzWm8L6OOVlUTSxKhyjY8b0NyYv3rtmBm?=
 =?iso-8859-1?Q?lgGJchSUidK78fjb0iXI6rGs4EBGRDkzK/da/SyIsc5n9Vkck7YzyBSjqf?=
 =?iso-8859-1?Q?1o4A6BYk7Fw8EMUgr0W44T/BrMuGdhDKHOUHms4delQd4hKYdAj3vIZ6oR?=
 =?iso-8859-1?Q?vfBQR48ZN+WP17Upb1Vo69wz3AqzsmnJfU1puQA9hsqiACm8zoWwukGCY2?=
 =?iso-8859-1?Q?86EVVsbtUgEIgF01g++Dutqtjj4kJXYxW/LDAVrHVSK40wCQvDxyYU3CWi?=
 =?iso-8859-1?Q?5LIJsyDn0I9BJ+xf1p9NBjsunB2fj7NCpnl3Dpxv1LDsi7J919T86gerUY?=
 =?iso-8859-1?Q?UixFL+M10oyPjeyjljHNuDQxWu46KHfOIwLV+HUdAWs0JXpDSzyE3WYhqU?=
 =?iso-8859-1?Q?cY/Qh/QzVFv6ki8HP61L40H+BQZxAA3aixg+384Pbr5B5ysD1BsSE6W0t1?=
 =?iso-8859-1?Q?Hs+l+TZq/sf0L+egCkxe039Ke7mfrbJLG2oquIlQYl6ek1CCCvf9MTpbvi?=
 =?iso-8859-1?Q?iqveSA7YnzGWq3/SRSQZKOUVLnNp+8Id+q13WCNf1dne53SYTCgo9Vx6Jd?=
 =?iso-8859-1?Q?5k8t6VXwTOCraEaXk00XwHVONm1kRVk7zAITREryFdcN04NT7vxzzDGGb7?=
 =?iso-8859-1?Q?UaPz3YJI5jwluyC8wMmOawEWot1ZlKhVES24lq7r+u9X5jVDNXL+R+F2vI?=
 =?iso-8859-1?Q?PGvcDxVNVwquvr0lUNCa3o+iUWoNzOlIFe1VkhzS6Q8V3TMeaXAa0w+d5L?=
 =?iso-8859-1?Q?xj7DlWKjTtvaRaLJYrwIIETNtB17FCB/MWpAkGzYROIl/UV79ly4gjSZhT?=
 =?iso-8859-1?Q?dVrwicZdQU6aBKiDnA6hu+GR7Te/lvGCe9jZ5Lmcdr8JINP9nf8Tz2PxU3?=
 =?iso-8859-1?Q?a6wKdpe+gV5nTmAso1AOEnFs9Mdd5jzyWdYJDwun7UPKqBtIJZvM5PHOdm?=
 =?iso-8859-1?Q?HAxMFg3eIJPoyWCXfBgXXPfYvshIXZ8oRRR8iKsgD9W2CJBrzu3NiIsoz2?=
 =?iso-8859-1?Q?ra/BdYOPKaX7T403q8Qof+L3j5moDaRnkRlA+wH79LWo0yPdwiA23sfnpX?=
 =?iso-8859-1?Q?QjTkQ1FSMmHjk0KGYPFgOnOYVt/6TOs63GkCoujpDt+8zHiLJBEGFScEWS?=
 =?iso-8859-1?Q?+qEvmzPpewQklya7zd2+UxIlwka6BpCDkaM9K+Q4MguhGnESpg1LG6crPh?=
 =?iso-8859-1?Q?hPVbfJDQZUCvGF/edi5Sxb/qUCRPEm1WBM0oND5AzbHwnHXnIGot3xk2Y+?=
 =?iso-8859-1?Q?b0rAJmKltvH2/whvx5p3h5MjwMalaP7H+hxvJu1EGJ3r3bJqF7y9OuBbHu?=
 =?iso-8859-1?Q?/bVf7Z7UTj4gaEoh154cRiXnCJdCBXxQs2WS1PKVC6dJuiqGZeVmfkuwpf?=
 =?iso-8859-1?Q?oMTj0qfkqe0S1Qo4boc9xZuSM50zR+COBYtjXNMWXJpSlHXSHMqAxGAnrX?=
 =?iso-8859-1?Q?XFggMbz9yRKnGVmdtaYjBRi77mXTwoF709r0PL0whq3uk6+t6ugLfPwKKG?=
 =?iso-8859-1?Q?3iKo1Gy1JrkKHWps++o4u/Ue8j16C+6eBHITJTknjpQ7NGLRERZHqpl9fz?=
 =?iso-8859-1?Q?UkE46wWJrnfTmW6REno1kob/IZ0178Tfo6r5tzxyaq+YhwSr4OFyMqQw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc9b298-3be7-4aae-079f-08da6a34a5a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:45:57.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czKtIAa37uZj5CjpJFdeGwTCRvyrnZUHHo8ego/K10uow/WU4qHdl5orTs+EPicJiOyHmCRMR0qXqeziRfILo0jE0zJybY+xni7w2e/4mA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200040
X-Proofpoint-ORIG-GUID: dHRKnJRlvNdloFKm10EdXXxdyj-sluIc
X-Proofpoint-GUID: dHRKnJRlvNdloFKm10EdXXxdyj-sluIc
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.19.y
head:   0569e1291a824471ea27c9e90132881c0232a3a0
commit: 898624b63a33622330468fd8007048dc1981492d ODROID-COMMON: phy/realtek: add Wake-on-Lan to Realtek PHY
config: i386-randconfig-m021-20220718 (https://download.01.org/0day-ci/archive/20220720/202207200005.1kAdinkP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/phy/phy_device.c:1772 phy_detach() error: we previously assumed 'dev' could be null (see line 1752)
drivers/net/phy/phy_device.c:1784 phy_detach() warn: variable dereferenced before check 'dev' (see line 1772)

vim +/dev +1772 drivers/net/phy/phy_device.c

6349084746ff4f Michael Walle      2020-05-06  1727  
b3df0da886ffdb Randy Dunlap       2007-03-06  1728  /**
b3df0da886ffdb Randy Dunlap       2007-03-06  1729   * phy_detach - detach a PHY device from its network device
b3df0da886ffdb Randy Dunlap       2007-03-06  1730   * @phydev: target phy_device struct
7322967bc1bd97 Russell King       2015-09-24  1731   *
7322967bc1bd97 Russell King       2015-09-24  1732   * This detaches the phy device from its network device and the phy
7322967bc1bd97 Russell King       2015-09-24  1733   * driver, and drops the reference count taken in phy_attach_direct().
b3df0da886ffdb Randy Dunlap       2007-03-06  1734   */
e13934563db047 Andy Fleming       2005-08-24  1735  void phy_detach(struct phy_device *phydev)
e13934563db047 Andy Fleming       2005-08-24  1736  {
ec988ad78ed6d1 Florian Fainelli   2016-12-06  1737  	struct net_device *dev = phydev->attached_dev;
2db2d9d1ac3722 Ioana Ciornei      2019-05-28  1738  	struct module *ndev_owner = NULL;
3e3aaf64941698 Russell King       2015-09-24  1739  	struct mii_bus *bus;
b3565f278a9bab Ezequiel Garcia    2014-07-23  1740  
a3995460491d45 Florian Fainelli   2017-05-27  1741  	if (phydev->sysfs_links) {
2db2d9d1ac3722 Ioana Ciornei      2019-05-28  1742  		if (dev)

Check for NULL

5568363f0cb358 Florian Fainelli   2017-05-25  1743  			sysfs_remove_link(&dev->dev.kobj, "phydev");
5568363f0cb358 Florian Fainelli   2017-05-25  1744  		sysfs_remove_link(&phydev->mdio.dev.kobj, "attached_dev");
a3995460491d45 Florian Fainelli   2017-05-27  1745  	}
c920f745f45d46 Ioana Ciornei      2019-05-28  1746  
c920f745f45d46 Ioana Ciornei      2019-05-28  1747  	if (!phydev->attached_dev)
c920f745f45d46 Ioana Ciornei      2019-05-28  1748  		sysfs_remove_file(&phydev->mdio.dev.kobj,
c920f745f45d46 Ioana Ciornei      2019-05-28  1749  				  &dev_attr_phy_standalone.attr);
c920f745f45d46 Ioana Ciornei      2019-05-28  1750  
93f41e67dc8ff0 Heiner Kallweit    2018-09-24  1751  	phy_suspend(phydev);
2db2d9d1ac3722 Ioana Ciornei      2019-05-28 @1752  	if (dev) {

Another check

c1f19b51d1d87f Richard Cochran    2010-07-17  1753  		phydev->attached_dev->phydev = NULL;
e13934563db047 Andy Fleming       2005-08-24  1754  		phydev->attached_dev = NULL;
2db2d9d1ac3722 Ioana Ciornei      2019-05-28  1755  	}
9525ae83959b60 Russell King       2017-07-25  1756  	phydev->phylink = NULL;
e13934563db047 Andy Fleming       2005-08-24  1757  
0075bd692dca03 Geert Uytterhoeven 2016-11-28  1758  	phy_led_triggers_unregister(phydev);
0075bd692dca03 Geert Uytterhoeven 2016-11-28  1759  
c2b727df7caa33 Florian Fainelli   2020-09-16  1760  	if (phydev->mdio.dev.driver)
6d9f66ac7fec2a Florian Fainelli   2017-02-08  1761  		module_put(phydev->mdio.dev.driver->owner);
6d9f66ac7fec2a Florian Fainelli   2017-02-08  1762  
e13934563db047 Andy Fleming       2005-08-24  1763  	/* If the device had no specific driver before (i.e. - it
e13934563db047 Andy Fleming       2005-08-24  1764  	 * was using the generic driver), we unbind the device
e13934563db047 Andy Fleming       2005-08-24  1765  	 * from the generic driver so that there's a chance a
2f53e9047e79b6 Sergei Shtylyov    2014-01-05  1766  	 * real driver could be loaded
2f53e9047e79b6 Sergei Shtylyov    2014-01-05  1767  	 */
5db5ea995fc2fa Florian Fainelli   2019-01-15  1768  	if (phy_driver_is_genphy(phydev) ||
5db5ea995fc2fa Florian Fainelli   2019-01-15  1769  	    phy_driver_is_genphy_10g(phydev))
e5a03bfd873c29 Andrew Lunn        2016-01-06  1770  		device_release_driver(&phydev->mdio.dev);
3e3aaf64941698 Russell King       2015-09-24  1771  
898624b63a3362 Dongjin Kim        2021-11-17 @1772  	if (!dev->wol_enabled) {

Unchecked dereference

cbda1b16687580 Marek Behún        2022-01-19  1773  		/* Assert the reset signal */
cbda1b16687580 Marek Behún        2022-01-19  1774  		phy_device_reset(phydev, 1);
898624b63a3362 Dongjin Kim        2021-11-17  1775  	}
cbda1b16687580 Marek Behún        2022-01-19  1776  
7322967bc1bd97 Russell King       2015-09-24  1777  	/*
7322967bc1bd97 Russell King       2015-09-24  1778  	 * The phydev might go away on the put_device() below, so avoid
7322967bc1bd97 Russell King       2015-09-24  1779  	 * a use-after-free bug by reading the underlying bus first.
7322967bc1bd97 Russell King       2015-09-24  1780  	 */
e5a03bfd873c29 Andrew Lunn        2016-01-06  1781  	bus = phydev->mdio.bus;
3e3aaf64941698 Russell King       2015-09-24  1782  
e5a03bfd873c29 Andrew Lunn        2016-01-06  1783  	put_device(&phydev->mdio.dev);
2db2d9d1ac3722 Ioana Ciornei      2019-05-28 @1784  	if (dev)

A third check for NULL

2db2d9d1ac3722 Ioana Ciornei      2019-05-28  1785  		ndev_owner = dev->dev.parent->driver->owner;
ec988ad78ed6d1 Florian Fainelli   2016-12-06  1786  	if (ndev_owner != bus->owner)
3e3aaf64941698 Russell King       2015-09-24  1787  		module_put(bus->owner);
e13934563db047 Andy Fleming       2005-08-24  1788  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

