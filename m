Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B168C4EBAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiC3Grb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbiC3GrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:47:18 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08olkn2108.outbound.protection.outlook.com [40.92.45.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CCA8566F;
        Tue, 29 Mar 2022 23:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i70Ds2YoG+cGeDAFCQSCAxPlagb+o9x/bwKlN1oyItis9U3Bo5Njn42zfe3OMN0V6+VDwUOJp7AWkyxw2Lw4Ib1guTrgq2xZjA9yHvqlxiZ726+z7JIbOqLFx+21sGTC8PVYdCe6HC7mibMmmg4XK+qJzLnllQG8OMbjrqA3VKZrxuUZIT8j6Mh1ZS0QtTExtt9R3eNMZmx13xqQKCjz5Vk4G1wPvt4ZCUO3GYSgpFQvi4UR053YYHax2mdHMNSDgrQzE6UpJZ+dT0GG1oFuo9KT1BWqoTD3ZYY/72KM+gnAR+PA7h3+GWmUU5Oi7mK8WuhE08NqEsZE0uoSJ5Po+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0H2ilRfTlNUvrXbh2rK8yvw0SNyekZpsm3rQnPqOeY=;
 b=lGvqxe4shwWetKNxpZtv4i3JQL+j0NENEpqhOepDTwnu1SmDUQbI94i5XkqxQ85/5bz4fYhsPSxf/X4m55qZF/qCvWiG6tl70Ab6d0+J5S9/fQc2Y7ciQs89HrZWVPpXdsIi0Q65Vco2MuGByr/8zEPcoaaUWquehS4i08KTDLWqzhzUA/wTTJ2BHT+L7xyKN0nb/oygYw8F3x2RI9fVBsJ7wTil93OB/Jue8r8stHjH7sxjZAhQTu68R9EfLoOU65yvtqR6kxtBT5yhBcQN+LKORhyuq9fIvC8ui3Ee45gtAnD4kPDUt3g4HDnPn2Yr9mboC6ieR6/glBdxQaIOsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by SJ0PR02MB8686.namprd02.prod.outlook.com (2603:10b6:a03:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 06:45:32 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::413f:bae6:4e5e:5ae6%6]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 06:45:32 +0000
From:   Joel Selvaraj <jo@jsfamily.in>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH 0/4] arm64: dts: qcom: updates for Xiaomi Poco F1
Date:   Wed, 30 Mar 2022 12:15:01 +0530
Message-ID: <BY5PR02MB70097230D0278CD6BDB23ABFD91F9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [nW/fv0TjqHjsbN25hDTdl+VPOP7Dzx3SobF/TGSZMioOGK4yIf2/MqbqgGzxwKYM]
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220330064505.243799-1-jo@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1b70a7-d319-42cd-3431-08da1218e2d0
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8686:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftFrSVPZzf6ielaGcyV2HX++Fb1D7nBA68U8wNuvDFDXwfyIDf3/bDzRLeCT8PjkzJDV7RIsKLcqJ5YKtTMDYQhFESK0HB/xptClVJS35QK06d8EfEiTnryLwz3zRg1iJbSuTKrN4YseV4rVrD1SbJcmCklNDvigIqL2J7tKBpKuLWFuq8BbdGggZ/ZE6mcdoiaCE0ZfROivv9h/NP7SCJW/goaK+b0WstFTRbmEX5ZtsOy9aQf1miuqx5TMkGEPc7trHyj29qET1u5R5p5DBXS9kQFfU+PsEpFJ/ui3me1G6DFdjgigOd1rnU2iTzLPJeKDPr9qtqcH006s310JR8l9fzoxJcK5RAPE3vekE0eI9nqSDPyfmEARIJuAT1xg6DIAkB3NvO++FS1S2ZLWwr/DHPa6tnZkCP0vAHAKgDRykh63kpfoKh7jYXUK/ZJgSP/+FIE+ATCvzgyZrKLjrGHwiQfeWDw2UBAo3zG3IkcLxof18MY/ps1XJdzZVWgeo4Pe1V/cyRmT+WFpiSxyJN1B8ydfvZoA7XeTr0Ryw7YTStEODHR9IDXXfCV6tzurf8wKj/xfrPMwXdpLrAq6Fw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHXt07teslQDmM7dVF563w31tfgPqCBUK1uR50TSM8RGIUFhFDD75tcS6xyQ?=
 =?us-ascii?Q?Re+BxbmM+Nxt52rS5tpuPDW7C6lRIPXo9tOvg23YqoQyMmV30jXOz5a9pH78?=
 =?us-ascii?Q?LbfQhBNCgclHITU5A+hYgXfPG/PzqU1ziQweHBcSlDiU28g/aOlH0J9unY9C?=
 =?us-ascii?Q?HA5YYWzeK7hC8D1p8TKjg9ur3luKEgeJBwOISHizZ2sSGmccTDfbqsQ7LY8q?=
 =?us-ascii?Q?+CMnA04wf4NdmFlpAVkWm5ciQKfEK/JpOHOuabRlq25LANAj1ySYMP093a6q?=
 =?us-ascii?Q?YcxGFqWERL54YZcWJBpVs11Qjurx2FQPimETT9EMmktRW4/P/oDwjSS6mQce?=
 =?us-ascii?Q?JYbMldSyWddApuvg6DsE0b/rGIKnMh+QuEtMRb4cpzb3ONeL5I77LsGWeOPG?=
 =?us-ascii?Q?AZBgGHG++S7qCGJgkOJLot5bYbDUe8nXHYrcw4Tgf8u66oYEdojohnjwjKj/?=
 =?us-ascii?Q?ySwkyyfxyaByDU2GCcC2Z/jR02T3r7244SbRM+G6F27BmJK9uUI04oQM295V?=
 =?us-ascii?Q?HzC+aX46XcdwzNNb0HA5Wqoz/r3Rwd7FaiVgNUE324uUSjZqSXHudNZwf0NT?=
 =?us-ascii?Q?sn+yTnnbAbaCoFwnwQvjTULEqAN3g/6kpXd3ohwEBw48uUKaQALxp+I05noo?=
 =?us-ascii?Q?lcNFi834DVrG3BDsFFC6VmXZHgrSN0RzK0y10zOXKu1pY8PlE1QUWLg3/wGj?=
 =?us-ascii?Q?eU3+WL89d9q5o6DjDthGcCLwFmdyjPePeg6Mq+lNtBMKydPXyGn3ouU+JfoA?=
 =?us-ascii?Q?0FrZ5pU2kDRtDGPGnuqKHw4dm52PRtSzu/EClTYppP/13+q//xqFbXj5XN4/?=
 =?us-ascii?Q?YDhLkHR/NUWGPjf3kQyqNT2df4fYzTzMxy4B8wInLJcG+dau5AIZvv2A7CnQ?=
 =?us-ascii?Q?iS1M2tpWEqG7hHXCppKhy0+qRzLKU9ipgN4MT9PchTPoJF+mvoMdr9MW+6XQ?=
 =?us-ascii?Q?sWocHh5TqjNFO9MxcaAtSTSvrW/bCUF6cFT8iHAPk/IxlOorYc1kJEQCB133?=
 =?us-ascii?Q?epNZxmnbvmMsKXfln5SZp1gkbjSyCYbqvMjtXP1y0BKHHbHOO9NC6jJTLYtR?=
 =?us-ascii?Q?jVg14PkCAxVn/iHmXxnlvPWnZWn7hWYx0TNwM/jTf9WN0EA4GjGJx6Asmnsy?=
 =?us-ascii?Q?mh2QGhOmUxdRr0HjtQrn0NvaG10zUG75LKKXmZPPAr6lRDcqHzIu9C//S+WK?=
 =?us-ascii?Q?wgguF/cRFd22/tax3fSJhjZMI0rtijaTzZSBUjjY87+5J9rtLKbav277rxUB?=
 =?us-ascii?Q?kUbJyqH8e5lyft9n5QK5ItWyktQwohVeYFwdRUsLUafLpFI374MuX9fSLEtg?=
 =?us-ascii?Q?pHa3vAemSfmMp4kk/kT7adwjDN5ECnURCx7ZhrIDY9RYojH1jmOWha57fYXA?=
 =?us-ascii?Q?SIv0gaG1DpXYGNV5pDu7U4ubAyV4OW0acJNvfiFfk/MKsTk/9MPwsTABObj+?=
 =?us-ascii?Q?eW6sWnUIYKa1C3zbisTdLaaRb3bBpN5AbSk/czyOOIl6juWYkdggbQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1b70a7-d319-42cd-3431-08da1218e2d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:45:32.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8686
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Selvaraj (4):
  arm64: dts: qcom: sdm845-xiaomi-beryllium: change firmware path and
    use mbn format
  arm64: dts: qcom: sdm845-xiaomi-beryllium: enable qcom ipa driver
  arm64: dts: qcom: sdm845-xiaomi-beryllium: fix typo in panel's
    vddio-supply property
  arm64: dts: qcom: sdm845-xiaomi-beryllium: enable second wifi channel

 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.35.1

