Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A95A53E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiH2SVR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Aug 2022 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH2SVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:21:14 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3925B58B56
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:21:13 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2110.outbound.protection.outlook.com [104.47.22.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-L6OWYYDuPJKhRBRMQqNgZw-2; Mon, 29 Aug 2022 20:21:08 +0200
X-MC-Unique: L6OWYYDuPJKhRBRMQqNgZw-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0408.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:38::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Mon, 29 Aug 2022 18:21:05 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1057:15ae:2a7a:de8e]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1057:15ae:2a7a:de8e%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:21:05 +0000
Date:   Mon, 29 Aug 2022 20:21:04 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Max Krummenacher <max.oss.09@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: add cpu-supply
Message-ID: <20220829182104.GA87202@francesco-nb.int.toradex.com>
References: <20220822075342.2611279-1-max.oss.09@gmail.com>
In-Reply-To: <20220822075342.2611279-1-max.oss.09@gmail.com>
X-ClientProxiedBy: MR2P264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::28) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ed8f01-7d0b-40f3-9e0c-08da89eb3cb8
X-MS-TrafficTypeDiagnostic: GVAP278MB0408:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: eHvgf+q8lM9ch9UEmp28ptc8dZtlCYgpLWZiM8ADyqhZCJhblOUYNMudfGIxHDW6kG7j6Tw+O7mN658XXZPpqOFxktiqUGgSRgNYE06E2VZ95hvE2zHTigCEJuEn3lDkhHb9FY29kG8CgEUAmLTRKt2yp/psOKQ4joaBiyVoAaEjQV8ZBJMf1X9UM9lthpY9RLASipkuKqEaDENT2Bd/Af3GS9gFF+ywj3gJbvzXMdOusI1snuz1WxOvemJeYce4LYxtzrOfcPaRHEq2FwFjwe89J+oQIa9G2Ea3v29AJGErFuwvbb3gGw2qzecCGfIMx7iLBVViC/wtABC3EHRH9bv98fI973yRicWNHc2jkrYWeCtR7j5dyeDCnFzyvzp4o10BrwbQvGA3Rv8abcs/1NeeX4u+XsStCr4rPcQURJvUadx4WmRCyPl6ElaZlPhbEu0sMmq+l11Jifsi1noIZnpLAg8LnjdFUHCXGADN8ieb5NgjSJ2uNvPYysUVRobw0N2/Itg5yWFod30mGqZyFHuaXtWJ3qrK92iV1736iMCy8NKkKXJCkhlJSvFLCR2m8w+BnEmn0j7Abh9O8qNozdRGJ7OGdcNYzGh5T+vaM5CP/l/2Wo9GqhoF7T+rEYp0XVVdr6ANlbLQDvrXASfyzrN2i1NtkCYukHnxHSmN/s1IlWACXJ9FMsqYTK6SK+0h0ypHnZR4ZLpVqcHH4r6N2aOBuoWGFbt2eWDo3uLZsOo1HaWErV4UTTTJ5V6g/zPM+p1MIPjG0TXegTYh0pA3Q2XlAhEmlR4gVtE/5oX1sSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39840400004)(346002)(396003)(366004)(44832011)(66946007)(2906002)(4744005)(66556008)(52116002)(33656002)(6506007)(8676002)(8936002)(6486002)(41300700001)(7416002)(186003)(86362001)(5660300002)(66476007)(478600001)(4326008)(1076003)(26005)(6512007)(38350700002)(38100700002)(316002)(54906003)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KizZN/K6UuWfzZxGQFMiT8GDug5vmd7u+FQQmZEkZ7YqQHs59ICVyYh1P799?=
 =?us-ascii?Q?WkWGwBiSNUkP8m22SiUpPJhy4VBVkgN6zkkmra+aPnn7NiC0owxj6XyYm9qW?=
 =?us-ascii?Q?MPjidGJK5+Aa/AoX0ZuWKbL7cvAbZW09RjLAkT43904apclRtgf8pAFbePkl?=
 =?us-ascii?Q?R4zDqS4QUbnx0sWOTkCu9MtI6aX4B077u2vGp3dA/g0606LTxS0er3gHCi4o?=
 =?us-ascii?Q?IR5ZVvTntqshTpfjgVRCWvAxcCbQIlwL8O+jY9uhgwkPthAZ6zEoyqzAmVaQ?=
 =?us-ascii?Q?/OHQjJ7rqZyywWlhSuclkxojKfiyyr+Qw9ABd3OvBHOlFoJLpf14HlFnwKx+?=
 =?us-ascii?Q?CIFxo44bt7ExluVq9uYytQx8cTZgU9BVjlYNZDLm/iuALGnSKmotGF/R+Wz1?=
 =?us-ascii?Q?eJOq1mg863tRl5p/uGQKEVLTSaAhu57Mz+oZHmxaq9rzYyZmpBaMRu/dFIZQ?=
 =?us-ascii?Q?B7fikBMwpFmbpijq1qBLdyyaqneRDi3JXC1C3S37vH8E43og4V1159Rn6Dl/?=
 =?us-ascii?Q?zk3Z83PUI1iaVBayBHX125bB4XLJ42l6GAj7dslks/77Z9CVJ8new+W+3VtW?=
 =?us-ascii?Q?4KfQoTGCnNyZHfkLxZVN/BWUyi1gKBE5esivxzzXThrKB5QA2s2U+AICDsHE?=
 =?us-ascii?Q?wgbTYuiQxodb1qklQ89q03kHNDYrWIDec1Nbe8E8Y6NNXOVzV1oHz1t/3xdz?=
 =?us-ascii?Q?T4Z6I6Uh8pDsZ/0JokO2nJPu+2fP4ZnIcRvY33M/ANxOmxheghMFBIH/pJMq?=
 =?us-ascii?Q?iZ8/YIWM9N5V9wsVFjPWB4qrO/frsnXL3A4DPXO0n44LwQDIZ9OtH6i30V8f?=
 =?us-ascii?Q?AA/eBXZvkEiSHvK+6iJ1FQXb+N5CuNRJbcoAPEbn6AWP0/zci0Uv77Igmg63?=
 =?us-ascii?Q?1FXl2UgptuubiMYp4Z2XP0odjIqoUpfu6yjLzSd6qwKiXDnhyZyzpkRV2S4h?=
 =?us-ascii?Q?UnLYK12w6qZQmCS9UTC+EsLvdOqKyiPh4fMcxJuVGC3QCSkK9DXexZb9dcWY?=
 =?us-ascii?Q?oDLvdbuI8Pz9JfjLmoOpSPm4G08z2KLF0Z+uU7+Jn0+mnRsgJ5eyX+0g82xP?=
 =?us-ascii?Q?ANt/bFArPTsjMqbau+LdLscHinudXPIfHN+kiYF9W8XH40JEtEYcT952f9oW?=
 =?us-ascii?Q?l/KCaJLrdaUX9V6XLf4AYrctC4tMoceUQwJYvAInMeXSozNEMo5c/Lu1k99E?=
 =?us-ascii?Q?2BsfTM/9G8Gj/FmhxnWX9Bo7Is+GIpwpB74CDvGr6TJWyo80CFLe8Eg/iHpu?=
 =?us-ascii?Q?2HQbNnW/Xqz/oGJnibOThrKrcVkWnJYy6sf5z2h6eay0kHdhV2JU4U8ofh6K?=
 =?us-ascii?Q?nlWdDcqZxr/tmEc9oHugcB7zwfIry9xs4imS1NhiASXSrlOXa8GSA6zqWkzo?=
 =?us-ascii?Q?Z7YIIa/GpAw/ixX1L3Cwvq4L+mHJMWH5pxNiUJ8gS3BSE1I3fXeKpOvR390r?=
 =?us-ascii?Q?4yLScYo6a6L4JErfKxRPST1U2EIuH98xYxU2+l8Bw9BqTPiKfQcjy3c6Efyd?=
 =?us-ascii?Q?GC5V5r/Km3K42XgSu0COLOlH160KFEWu54LZiqp9wcquL20YgvKJDsa991eI?=
 =?us-ascii?Q?qqYhpm1dEd2wWOQRrR/6M92Un16fZIvPnaTh96zg081RC2HZR6S8ev0DIAKd?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ed8f01-7d0b-40f3-9e0c-08da89eb3cb8
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:21:05.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya7WYC5qbgXRXpXXV2mG8DIqgTOnGWIkf/OfnBuzGvb41xIjg/z+qJL/UG+9ukq9hmIZb/RNpoTAQK1oIxqBOVjQ9Qpi4kHytU7R3e5ghDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0408
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:53:42AM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Add the cpu-supply property to all CPU nodes to enable the cpufreq
> driver.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

This would need a fixes tag IMO:

Fixes: a39ed23bdf6e ("arm64: dts: freescale: add initial support for verdin imx8m plus")

Francesco

