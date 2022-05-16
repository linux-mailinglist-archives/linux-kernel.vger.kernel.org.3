Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27B5281DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiEPKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbiEPKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:23:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954BDEFE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G8kLWR012365;
        Mon, 16 May 2022 10:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bSPEoXgWofcGf+jcbLYKfbtnkTzmT3PxW7xlJ0RNt5E=;
 b=Yh++03sIOQXtnAMlHsVQLPGxwEjgEQPuGVWxd7rZGVyByUvvnTUmfhCqov4ZCUymD9vW
 OguEyJifSXEmJ8iZ9qPCL8pnKh4wN5basOrvmXb96ARvC/jfa0zH0DNpAJDQjwOUHPC7
 aNrc35lLpslzm1wCvOI0N9A218mxzLxU5WjVfBknjSYLlULOSACmHW9MP53JCcNxNoLx
 K1MOoLcziKmvfhyjJRPwX6RV8u1lXAkR1iBp9MR17tZieX2WbovOXJ1RtObyDuFfk1KV
 4KANsusBJVVGJaPRYRc+PXblBEQqCYNXeDOk/oY/YIXTOQYYsv+k0v+MRt2Y+8JuUoxN 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytjtje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 10:22:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GAFgi9038865;
        Mon, 16 May 2022 10:22:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v1n0du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 10:22:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh6t+iCzo06XizDi444MnL5CNEIpjnfR5qlu7AEA/lu6Xw4SdMWbAWkeGHiqNpbZUk0pWwZucdRC/RAKQO3GuSzm82c+htB4OlNJ/Y0pX9BNDl9OK+lSqmkkn2RgWiM1ZMwWzEL+nGVfrcXHlkl+YqRGOg4YiIRDngDUo+0u9VZXs62onCap0tzpN4u+0oJf0S/D1CZ3GGBavHv/q4BezB0iuV7CZK723yLcSCvuN0RKcqt8tI72VP8gDbOCgdWBvaSQ9i3dIxE7g9OR3ZAO/iysTA9NO7gx23TP41IXTSTU6hGODv+byjBtgras07eMNyL4OiIRK0JXIxV/ufoYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSPEoXgWofcGf+jcbLYKfbtnkTzmT3PxW7xlJ0RNt5E=;
 b=l9zxGwSjurzpOE9chAiSPHrDgYcwCwymZL5awGSnjujqP7w7nQQoK3xxDSMall3sYHkWd0zq11EU/bczp8N2PXEvWh+dqf5lKfZO7z71FEP84G/ZfDo3yc0cELi+i3ravb+MEPvUmdB7IZz9a68cVwAXG8RE1AxFJ/Jg14Ga8z3tbGL54gMHkISVOQ6NkcDUyDAPOfpIRQRIaGORaKoDWwq2Vqna2w4lrlIB53apsiWHhiVfQyu4ZLT2smrFPiCDdXyBgRPj2CnhITMs51xAMvpdLsi2pZ3kBcBL+63NTiQXNHLfI8qLeallkGdvzP2yIwxbXrtuPnVNYvhifjQy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSPEoXgWofcGf+jcbLYKfbtnkTzmT3PxW7xlJ0RNt5E=;
 b=Jzp21taT1l6CYJ7F6Q8DA82/dyh3fqS/10+x3J6emXG0KjLz4ecRUxcIcrLb9Aj4B2E1OR+X24/KN/LeK9tNKx/+mRCkcnzWKsTs2qTT5Dv9wGyycPhHJZ41RjBnwdlI10kTi74L5vJ3ARuM71/NfSNqcTrD8VqSfPVl4j2Vqfg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1684.namprd10.prod.outlook.com
 (2603:10b6:405:8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 10:22:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 10:22:49 +0000
Date:   Mon, 16 May 2022 13:22:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     paskripkin@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] staging: rtl8712: fix KMSAN: uninit-value in
 r871xu_drv_init
Message-ID: <20220516102231.GK4009@kadam>
References: <cover.1652618244.git.wanngchenng@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652618244.git.wanngchenng@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5366bf9e-c756-4066-50df-08da372606f7
X-MS-TrafficTypeDiagnostic: BN6PR10MB1684:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB16842A5E17EDEA5E7D0DA0718ECF9@BN6PR10MB1684.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/3UtwQA3pf6FC7lLWKO+u3JskrkouHhHDGX+k3/gmxGRTQ64s48arefmL3OOVTZ+UmJ8YMi9Hy4JZUjLoV15MCI0sdVhxfRRd+ZNrdYPL6yhju55T6UhzzFjQa6i8nyDZFIRsFzEuIORE/hdQuX35V1Ahjxyd5Me85hTZsRRBWF0HNlQrcakJW487UgGI/uR/U1/80JYwSWShRV5m010alhMtJ2pUuSza2K3nWHvEaL0o/VY4sNrdW4aF1beszsM/nBCFXoKdoLQBLm8q9I91uS62WR487bNe/APZdq4vkf6agYqFs7fzwK6/5/8oS/h5xrzw5DgqPRpT5s+2kBNdKXe5V++Rjfb/NcHfkTA+1cxR0TweD5fKZyUlXkeb4QoSifwNTe05mJHp111y54IjtcyTZWyg4sYKvTsYpsoqKbHR8DCpdLVt37+y4RSOk8DzDxz1FApLSD4huI0zMQI1QZsF5nFfmH2OmJApz+orolSCBMVwxX/gUEz8uGStEXgrYbdbLDu/cgQTpaqAFqaH4vwKWyejn+yb+XyzSe1DMD+bXYTIETVzmf4h4Bi34S1Q3pyFlVRMceu763c/9DDhN0UjSoZyW6KAPw4PSImwg+MbudH8e1L3lf13FOdz0Cl/SJrmQiefZdV/BTHBBBAL9xiesJSoFXsgjnPCO0C7oUNiYKbXkPCnnMPRn/AYm0u+OruxlZ9NWwRMZTdHOwcwdy5mlbC5unfgwgHDLXJ8IrPgsVjJ61AKXuvJFFwVy3aBN3H77oKEhvlQBwWhH9581hdX55VH6Xdj/JvPTa0wY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(966005)(6486002)(186003)(6512007)(52116002)(86362001)(1076003)(8676002)(66556008)(4326008)(66476007)(83380400001)(2906002)(33716001)(33656002)(8936002)(4744005)(6916009)(6666004)(508600001)(38350700002)(38100700002)(6506007)(44832011)(5660300002)(316002)(26005)(9686003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dl7/fzvlFy81TgTehWatHysKqksIDCvxWVAV3nq87a15CnnKKdAunfAcikIH?=
 =?us-ascii?Q?7cVhdIagrKEgei6/etEZRfuABbD7lF7MB7SSPu847Jxmf13Velmee+IQ6m12?=
 =?us-ascii?Q?Y/SM7Fdh4gddlcjCf7lXRFqAhu1GAbvCQdffm2Ef0qlxgDfztM+aWTUoVS6C?=
 =?us-ascii?Q?a2CRKUGBHJWQ2K2EA3FEGpZbit15y/J/cA9GB+HbRT2XiRREsPwkOl8BfOkK?=
 =?us-ascii?Q?EiZhNKQEiPFCs4G8obNjQbx7vOt5rn80Ve/CpKVKojVO/atPB2OTl/P2njns?=
 =?us-ascii?Q?VPXqueW6b3QO6DVtgCooNB8TjJnLRvGwQ3JTkNapk0Y7zDNH+SAYIX79ZVNy?=
 =?us-ascii?Q?MyQZAmGjmPzDf+JiUYmp80wXEnCJd4c/dm3rd3M1V6UnRz+/+I+HvFrbZqYp?=
 =?us-ascii?Q?gb6XNS9lfV5wPgvPmzWY/NH0C0kPV4M3NRe21J+VkTEH0jnIwAI0AD7WZ01S?=
 =?us-ascii?Q?UuyQRWIj8fq4mpzzfwpEz9MIbPFdTRZYCCg1spX5yKd3BMcNR6trFawthEjP?=
 =?us-ascii?Q?vQLnelH6llR9oTO9aB5+I1HgZirExQxzpdf3z6IZMreplcAHykvjYM48U2t7?=
 =?us-ascii?Q?CbfsauuuHe9HOOH7GT8faW6vqOGAolwzhyZ0+0aB2XM0wqfpRbg5NwFAXgIx?=
 =?us-ascii?Q?oI3+KOQ40/peZlWxvLRMsDgp01deppXb3NgKm9rk1qJ+OE4UX1Epp51hWOjK?=
 =?us-ascii?Q?aJSfMbCTGpvKnbBi4OEscUSbkDQ6hxE8IjTy3+4Zzxw013ro5Xj+gSajMP6b?=
 =?us-ascii?Q?vhG23xan6k/BUE5UF4r+Pw4aGjET35UlGyz4sfxS6+rvZUdOSdwASr0q4ZYV?=
 =?us-ascii?Q?COO2ZVxkhvckvltRnDT2p+ZtXdkMZ6YmD9F6/QJEA49pBuh/hXg1pnYYzwzP?=
 =?us-ascii?Q?X21ApetSXPtQnF8aiLW3oVdPzvhOCynMv1aNfzaV1Z/o4sH8MmWRDaczTkus?=
 =?us-ascii?Q?vjEGkF492g7iSOmh2X9GzV8i4e80CxgpGh9DYvCWSyz26sRDiouBiMp5cq3x?=
 =?us-ascii?Q?lNprDhOACU1MSUrN+GVOpkiQ/s2CCSpQWCSVmf1nX0mD4apax+pE3tcXf4Jo?=
 =?us-ascii?Q?YBprAkY1ldUqSscDeSMvfPFTU3HgI4OUtqK6NwM6Pt8uUs3FBv2Mdtwe1sR4?=
 =?us-ascii?Q?1u3LvVQX283KbiR/sfFL8CFzp6/q0mZV1yhWelL0M6JENtxpW315x52tj/B5?=
 =?us-ascii?Q?gv1XZzMJqYjnf3UW6gS93IVJIASv/vMUEHaj2c7Y+7TUlbKVvqVnIb8zDrOD?=
 =?us-ascii?Q?qa4D79aPhYPLO6ffwD2CE/be0YrU+OvYcQnnfAm8/qDr+9EMdfoAcTJonOfS?=
 =?us-ascii?Q?KJMoyg+XStkUWL7lgjgArV93aKrvXse6eh6NPluEKO4FAdZUxt3bO382CAeh?=
 =?us-ascii?Q?HNPaYCikPpnPQ3Dhlg63z8M5XUN275oiEstzlg+wczsv/FPszO9aLCaYwIJb?=
 =?us-ascii?Q?8vN7z1TSQGCCYacX+vcOZGikT6z6EZGShhqfUpq4rURJDHtqoYh1o7HZS0oz?=
 =?us-ascii?Q?WpKOSRA+fajJKyYnlM+3KRQq7Ho44kvwmmKVdeEtg+0vHZnWTYZtF52un7/j?=
 =?us-ascii?Q?3pU4tJztPRmjhJ9rt39kn+KDS2Fr4DRflVdwOfqMcd2U5GdoQ6DxkFk0m1jF?=
 =?us-ascii?Q?2mK7MpdwFUZo5B43RHHm9rdMp0yJ31CdOml5U3DPFuENIMKhUxwEDP45ZkfR?=
 =?us-ascii?Q?fccIozarlek3052XB/Lva4Lhzohf7f7PlrrNDbLhUIwCTEtBM/Dg70hfSM/Y?=
 =?us-ascii?Q?WNhgLlMOyFyAz1TqXIESjArplZGsMV4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5366bf9e-c756-4066-50df-08da372606f7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 10:22:49.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyNbRfY2mVglfWoJMum4D/1PHrpa6k6i63oVwHosbnWoPv5R27AqLS5ORW222n/mA+0jnMae576h9V6aIeOyQx0ZH7snSE9LpoaQNdLCRBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1684
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_06:2022-05-16,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160061
X-Proofpoint-GUID: B2ZcNnO0RTjkXphUJs8OUDEH8Z-W1acc
X-Proofpoint-ORIG-GUID: B2ZcNnO0RTjkXphUJs8OUDEH8Z-W1acc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 05:21:50PM +0800, Wang Cheng wrote:
> Changelog v3->v4:
> - Update commit messages.
> 
> v3: https://lore.kernel.org/all/cover.1651833575.git.wanngchenng@gmail.com/
> 
> Wang Cheng (3):
>   staging: rtl8712: add error handler in r8712_usbctrl_vendorreq()
>   staging: rtl8712: fix uninit-value in usb_read8() and friends
>   staging: rtl8712: fix uninit-value in r871xu_drv_init()
> 

Looks okay to me.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

