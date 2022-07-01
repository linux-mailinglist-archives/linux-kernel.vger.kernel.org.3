Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A95562C92
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbiGAH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiGAH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:27:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE836B81B;
        Fri,  1 Jul 2022 00:27:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2615wZFg010382;
        Fri, 1 Jul 2022 07:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=tnHaVCW5rj6GsBxRl1kSO8um02WAbmkdPDzF6rC/9j0=;
 b=KgBJ1mSc+VToxybzLmtMsucdwN8RSxNBfUBnfs9kypV6t5ciWIrpMNDx7MG5dDnfc4F5
 40Px1c+HvwTuC5ujHpuPgZ7qct3toxfP9o/Oa1ha+3CgKSw8GaDIaYSAyWGTL33n6Nfp
 LEyEnQhuoqX5WzOxReMANygRZjKclJNC8Ti9l5uAOt9la/PXbgKm2VVccL1wcUNUMNpZ
 bHtSDW9z6wcRO9KSQCmzTFZOtc5PhrkITjbrBzjswXJ+eTx9w/gc85AUrpRJy+HPSksB
 uhB4rygnUIqMb3HXYbAfjsCpKLsYlXNKAkuAhBAddpu8NsRM2+dIBeW+7MXOUPPpuwpD 3Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwt8a607f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 07:26:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2617L3Sw030169;
        Fri, 1 Jul 2022 07:26:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt56pj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 07:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiidLei94FrfbkBt9P/mLXY2Uu8Nzwcs6Rxym72wL05Ui0OG45KL4Za/fMYMYNU658fnIx535USgHC5r62YftrK+GE6DWXNn2dQJnp3g8UmoQiOlPBHcrDpnksx4Szr88fGy2KFK8Uux/xzJDmi3wRtPn3hcpXc5GHDHEeWmX708k8atv+dEyJxqItZux4aB5NioVxLY1vvGFAbd7ZaUoJt4atHfl0copg/BanSXBCSbPuKc6jzzp0IxBvpfkDdbmrG84IhfMNcuJ7V4cQUcwWrgcKA9+0TCVfNPFbkih8sCGB1de2OYTIpFRrCxGQTlv8wLxtaeBoXXat5g1wsjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnHaVCW5rj6GsBxRl1kSO8um02WAbmkdPDzF6rC/9j0=;
 b=ny4r/T+CCcg0UshQJCHYrdSaD3opTkF+DA/Te0idcTVVagXNfS0mT2hkMzyeSGHrWCHCK3fROOYM6GokxBShHAu/zkWePaoFfTov8PkY9f2mqA8y1TBbUHCp/egEWabkXO0iTb8JPVghXvs0ay+jCxlE118SaE7vVNNjo652moUD0S2chn25+/0t/1vt8KoueWu5KZGefPAGeAFsfBMoJWoUuDj7EwmjytixOJEqPw6zQo6TQM9aR4DGn6qfe+QyEchsNTKsNqK+xbIMJqzdtQtbBC+cclwTeIz6tQPpD4bdTQx3BBcLk5nAESAZFVvlLuvcu64EwTmlSOAs7xDCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnHaVCW5rj6GsBxRl1kSO8um02WAbmkdPDzF6rC/9j0=;
 b=vQUsH65iGSpEW30XnL3Yqn74mmPBUkGYU9BfQ+iZEgUZdjsAf8JwxEzMqepY2bJWVmD7ktZ1c8TatS4iYtqTOcubki8xvGwfHj5lQV2hWy/Zb9A+ZRSjozYTAGvbwA4HNWQvJWIFXjo2r44/0YKQ3GaqtHGXHQoZnPru6UMWMv0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3458.namprd10.prod.outlook.com
 (2603:10b6:408:bd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 07:26:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 07:26:52 +0000
Date:   Fri, 1 Jul 2022 10:26:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kbuild@lists.01.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        senozhatsky@chromium.org, yunkec@google.com, lkp@intel.com,
        kbuild-all@lists.01.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v7 2/8] media: uvcvideo: Add support for per-device
 control mapping overrides
Message-ID: <20220701072625.GQ11460@kadam>
References: <20220617103645.71560-3-ribalda@chromium.org>
 <202206301144.r7yv0yk2-lkp@intel.com>
 <CANiDSCu1+0C7mfmm20ERVdvbzyJmoifnp6tcjEcd7EJfUAijSQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCu1+0C7mfmm20ERVdvbzyJmoifnp6tcjEcd7EJfUAijSQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d08bce0-b489-4d74-f331-08da5b33110a
X-MS-TrafficTypeDiagnostic: BN8PR10MB3458:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PxfEnhfzHxJoiuRES+5eqfU+veknPpx9MuCHYN6mTXVw3c0bISca2oP2dZ/IOlSj1kJUoKKbYtDXL1bUiK1ZBLnZ/Db5Ly6ggFcPWZyYECzyE591Aa6nCfze0anmHkD4SvS5WmSN3o1UR9+HGRcYoiXNiZSEK8sXqD5cAiVXlAQ7AB5DJUG4bY98B3bUdCmjCyoKD7aIpl8hlq4VB0yJMd+AgOVrgVDx49Z1fYJxX7jfnQZQEu5fZuNiPl3Ljh/FgsREICISeMxP+tC+66QjF3g5NBm8BRkb/6mhS2XV2ivaJ+RPd/e1OLmq3NCQy+qWqbqdyoneduPlX3vp8YyL+cltMR1du52Jedek2txQIMsPCGQank0QaZ6L2344cbup/Tbn6BvMsuASXqI/nzLLivAbp5eabQHbExHMXK6hTihxanVEXQHce008uCGItvQVZOVMH8memxducbgg/Tzz75UspoPwKpoP2ERRKUCXzM8xyW39m4+lyLW0Ce8PebV6YhsqKnMSwj06OjlHNThycFnCOr3K7gAze8h9ao2MmfNnjL7exFeHhoWRYBKO4HEL2Uk5F5kMXnsTZ1zEgre5M0/53t8XvbMWcqDNGxMyhipjrJTN297z//HcbDvv4sMyODjqpYv07N6CZTGvpJXKVP0sgIHG77z13otk0wZ4fd54I71OIoUHElGFBUC/OWsLXOC8aCYPOFdqDD0omDqeRjmimBcu3aDzMo6WQR9AHinpwznbnA/cjXXxaenTUouUlktzGcDmYuhbpfuMUQT30jCxNrkGM1tIWpjgXW9H3+5QI/gZkfdVzdN/lVp1zWvuuIpnp2diZZhJasyNK0aw5S51KWELIooWeJN1P0+M/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(396003)(376002)(136003)(39860400002)(186003)(6486002)(966005)(478600001)(38350700002)(38100700002)(4326008)(1076003)(316002)(6916009)(66556008)(66476007)(5660300002)(6512007)(6506007)(66946007)(33656002)(9686003)(26005)(7416002)(44832011)(33716001)(86362001)(41300700001)(6666004)(8936002)(8676002)(52116002)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnXpWzGKORxTKriFf368p4Ey6v86nHbSLAmzOntNPzc/FXyjGyM6/v1nIqzX?=
 =?us-ascii?Q?hbcT8dlgQ9nbrYQZ8z6GTE1XiJDV8vUF2/bRQ3lbX8zCPnZzsWuS1gTkUNIc?=
 =?us-ascii?Q?pf9Jbz/EiYT1HOBJ9/mBg1flHZOxwqnm3XXCvHqpJuEvQZ46XcMHtYk4FulQ?=
 =?us-ascii?Q?juY/ov8ICScT249cGx1LRuyUAqVSmAzv1eHAyJbGpHrj2wOFxyo17QGMlQ/9?=
 =?us-ascii?Q?SaLbCj5Uz9LFnqNZHsOZW1wcya1TD10Ulj3rgcglPxbEMHmVZblSQWQi1Zbj?=
 =?us-ascii?Q?QDqYc8JHW4UCVcSHEbULdN/OIPnNlUj1JBtEtu95WNr6GN1JT7H61y4XDMC4?=
 =?us-ascii?Q?1/JoQU6ipwJqGXU57iRinOo+hLJjZH41ojYdKqmBl5m+vbHvjqeZpoE6MqoD?=
 =?us-ascii?Q?MTVXH77oam8RILlml5zsQ0k16scEs9dADmB1sOmJKlu3IfDqMoEh0bgScxAk?=
 =?us-ascii?Q?g1pCEQ+v1dz1hHKGXbhBnesGDFdiixEwubcJqo5jRuV+ND5RzyT2xIFjacP3?=
 =?us-ascii?Q?bgjixd4R4kr0mBPZHl9hYfL9IqPZr3HY32iT8n+sqkXMEF7Nj5l/EAXJF43u?=
 =?us-ascii?Q?hbtcrcX7GAnz/ei68jMJL/sLg4SWUpFrfCWauWFQv657DKaRJKxiZYUT5TXY?=
 =?us-ascii?Q?qgtGve5nbq05nZXrmsMI0mLersYRoQLDXMdSgECovO5kV9x4Gh+/rllvjriK?=
 =?us-ascii?Q?2eINpdoZxY5/VZYyDdwPrYLZbA87FS9uAtV3VfSxuc+9QwfzvSKFC69AtHrG?=
 =?us-ascii?Q?NYF4cGutVduazhhvQ5TnFoFHKulVpsjmK/xA9plnTc+K7Y6WhMLb6oPFNehz?=
 =?us-ascii?Q?Qnu5fL/k8oKUf1HUdGt+/btWxSNK7sMy+K4En6WGvNIwqOfv4LnKnIe71bbu?=
 =?us-ascii?Q?GApNFODPC5K4Gl+ZFxMYnyExhxscGUwKObBMSS6B4Fwh1GE4vVgIHPp4PEj4?=
 =?us-ascii?Q?UinbCTwBCoAZDpxEUeQEFrKwTb+UtYiNNoyrYNuHNNEgpXPnvjkFbVjtqNJq?=
 =?us-ascii?Q?pJg8HoE6i1Hd2RwuVArnS1cdVcblIjzDRAGBmNcXqUZULfO9Si8I4c9itKzj?=
 =?us-ascii?Q?tmqmEPaqzVy5tgqwWpxSlPJgCtbKy4vOl6if++5/CrfB+fSIa1QxYXLdww3K?=
 =?us-ascii?Q?hHj60akb33tlxcn+BEZg/uO/nO18lhgyeh4KRG+jXc1Zy62ajeiYTfGsF5ry?=
 =?us-ascii?Q?AdqKRjuo7/7hXGaYvjSy/6dW+XwychYsGAGtUpn0fnJEL1eZDV0iLcUkuL5X?=
 =?us-ascii?Q?f7Lw+oRyj5U07zkfVG76ENL99uLiMr1GI8c/AFWa1UxOX+OA17S6+dPzv4G8?=
 =?us-ascii?Q?MKPZPBB5dNW8qDoI9l4MEHRqELarPPUdjfdL0Dk5MXD/o1R+GEtDpl+P0MGL?=
 =?us-ascii?Q?pZfYHiBqT+xYmOogBPlFFTtFC8IWtTmsWhjksOfHqxrJf51zeVlaAtC15dD+?=
 =?us-ascii?Q?5b4nnwNBoiggtfybdVcUBHz3PrvbK2mju01hROanpMOj/KXj67auCNylTfI1?=
 =?us-ascii?Q?wXlI/monBnmcmQUB4kLeGLxOf5X6orIUwFBXgHCteZUA9ggrYGyS2Hh61++b?=
 =?us-ascii?Q?Hrt02dsKQ8hbOpvNB3UFJuk8Eek2EanVUcCcIlCokbI/gbdGkcJdRxlfbgEo?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d08bce0-b489-4d74-f331-08da5b33110a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 07:26:52.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmExewhtjyfciP6RGe+bbuWDbtgjAP/cGQJZ2K6Uq/UZ450VWOOd8TPs1lzk3NDG1jxSaT7HrIUOGCDP+GC1oAv4qDNAJ/dYNcCwvxeb8lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3458
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_04:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=895 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010025
X-Proofpoint-ORIG-GUID: yXNkXfnSRvH2mM1KcNaeXp2LpWDskif-
X-Proofpoint-GUID: yXNkXfnSRvH2mM1KcNaeXp2LpWDskif-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 01:16:23AM +0200, Ricardo Ribalda wrote:
> >
> > "mapping" uninitialized if chain->dev->info->mappings is NULL.
> >
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2457
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2458     /* Process common mappings next. */
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17 @2459     mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);
> >                                                                                                ^^^^^^^
> >
> > 10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2460     for (mapping = uvc_ctrl_mappings; mapping < mend; ++mapping) {
> >
> > I'm surprised this made it through testing...  Anyway, the easier way to
> > to iterate through an array of structs is just say:
> 
> There is already a new version under review that fixes this:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/20220617235610.321917-3-ribalda@chromium.org/ 
> 
> 
> >
> >         for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); i++) {
> >                 mapping = &uvc_ctrl_mappings[i];
> >
> 
> I agree, and that is what I normally used, but that driver iterate this way...

That's not really an excuse.  Imagine you were a lemming and Disney
employees were trying to chase you off a cliff!

> 
> Thanks again!
> 
> PS: Any idea why the test was triggered 14+ days after the patch was sent?

I don't know how kbuild works.  I run Smatch on linux-next so I would
have caught it eventually.  Plus the clang people would have caught it.

regards,
dan carpenter

