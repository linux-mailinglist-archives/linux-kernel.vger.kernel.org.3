Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74B5287D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiEPPBM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 May 2022 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244861AbiEPPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:01:08 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 08:01:05 PDT
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.111.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDFE51166
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:01:04 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-EYxuyDyvN3qmfhEtW6pdIg-2; Mon, 16 May 2022 16:53:57 +0200
X-MC-Unique: EYxuyDyvN3qmfhEtW6pdIg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0391.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Mon, 16 May 2022 14:53:55 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f465:3051:c795:3c2%9]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 14:53:55 +0000
Date:   Mon, 16 May 2022 16:53:54 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        max.krummenacher@toradex.com, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 02/17] Revert "ARM: dts: imx6qdl-apalis: Avoid
 underscore in node name"
Message-ID: <20220516145354.GA121079@francesco-nb.int.toradex.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
 <20220516115846.58328-3-max.oss.09@gmail.com>
 <86815346-209e-304e-3565-b4160afa48e8@pengutronix.de>
In-Reply-To: <86815346-209e-304e-3565-b4160afa48e8@pengutronix.de>
X-ClientProxiedBy: MR2P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::28) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57c95e3-9e79-4a62-5115-08da374be65a
X-MS-TrafficTypeDiagnostic: GVAP278MB0391:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB039112D4F4140B6FBD538626E2CF9@GVAP278MB0391.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 02PhJ+YQdJRG7X6UyFktCIvGB0JXcGmUcY4jvbOhXGXMDp2X1hX1dlQHS5kyl89qUbfgCtkLKnSnyD6LBQasBcskbYsmtk14nMq0brLsmyHGeUgky/mB8UMfBqj4VDxqsWVf3hbS7HBwiK7zsW2SGKJf8wMYinIJK13DDDdij8Tsjwz8ja4agBg1ZMiCoo9LgTkm286lBu2+kaQR/31bjG/ioi3pUMSMkop3s4x5P+99HRY58nEQiiekQsyBReMShS3wkeicENclJ6c4Xt9WJov/EbS+oAc2x6peWhS9LcU2CvIavya3uZu/1dXJaz14uKRTmOsUBM3CXKleCYwemgSIvtxouDZ5AARvY8yYU1Y532+32ogW8AZv/V2kst67tD9368dXgF9YBcloB4uqjKSIEaZSHiXQJ92UPmlo8hrrpvuDkjewJUb8ruIu5Ldsj7i4lnUWburiac5d2y3KgrGyh+K3GRIJkq3r3MxbQUbcDUYyer+gSfsu2GOVmEwbuJCPFWUZyx5snneO5T1Upees+VqGhwT2GlG2Z/M6c5rCpbwojQjDm3KPZk0ULNueebli+HxB+rWE6RzGggpZztgJm+jxv1NRHKYHlLkwAH58oUt8+kGNtoH5C0ARAnZDuWaIM0GtlBUAXWnwbfAk8kF8r5WojnPxOvUsfQYKeh1HBnMkpvFoZExKyTttHbagQp0vO0bOL5n9hxhLSGJT2fohOUs8/GM46i4BTbsVx1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(366004)(136003)(39850400004)(396003)(376002)(316002)(5660300002)(52116002)(2906002)(41300700001)(8676002)(66476007)(1076003)(4326008)(186003)(83380400001)(66946007)(66556008)(8936002)(44832011)(6512007)(26005)(7416002)(6506007)(4744005)(86362001)(53546011)(508600001)(33656002)(38100700002)(38350700002)(6486002)(6916009)(54906003)(32563001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Ea2AWrHy3pPp3pJY3icE9k2hVc4bY3+kPIe0RMkhjKszNeqigRIQE1qj58h?=
 =?us-ascii?Q?IyHFChnwicWdZrHkk7tEpuJZxc0D9WJzGgTAKel39CbMv0sZjk4FHCKe2vvW?=
 =?us-ascii?Q?rw49qjl4tWB9Wh1YwgDzSqlSTORrtwinxzu9bjsfmo5egCw965lua4QRayzx?=
 =?us-ascii?Q?YYImuE8V7D1hfCnOcu9bN6BGTmQZm54243JPstCjR08eRl01ELysKqULZW/K?=
 =?us-ascii?Q?uMb1A63RL52rMM3INYEKZC1MkuGwNltFHLHF8fVYBEhlbYjmaU6GCZX7WsM+?=
 =?us-ascii?Q?W4LEW87CPHT424/T/K75Xy/ZGbRlQaqSizUiXN8vZaDwp1SPJf5T18/yUChB?=
 =?us-ascii?Q?BaY1xjNoqHOAETp5b9a5t2Q8S4Q/RcQJgk7dbtRt6ommx85wCnFOEx1djADW?=
 =?us-ascii?Q?EIUEfWLuVwCR6plnjimLQJSprC6mwTmi7zkUMymNmTBzZvgWUxIu3dP4Arck?=
 =?us-ascii?Q?yMRh4DE7IikLDrzD7gLb6vTQva3xHdBo8L87v1JdNjuyEquKmiYAqdhYLCA2?=
 =?us-ascii?Q?hJZ7xf6jI+yj1vmy7rviz1OqwQI4emMn8G50FLQRplxPmW+b3U0fufsARhz2?=
 =?us-ascii?Q?RBw14jqv5KREGjfHEbSD/C4zW4xDf13gWvwUJinEgQbKrIH4Kxfa/J/gNa5W?=
 =?us-ascii?Q?PnjF+jWrurlrBXhheJc69/DMTetlQCmt3RPa3AXtMklQQSCGVXBaGVq8Sfs8?=
 =?us-ascii?Q?mC+Cgfw9yIbxNRo1WmnzOgjjM43IEhcJiWyRaUPebPmmbc3l8aNyGc3kqe8R?=
 =?us-ascii?Q?Q/uVkTSVH2DZtEx+32sInmmQtmmY7YEHKUKkmSweE0bhc2Cs9ZoY2qWg+TfE?=
 =?us-ascii?Q?QgGdB6SvjsOrb6hwsRcUN/xwIWoHgf1GJ9sgTiTrXs0bXWg2HfsnOIWb6MpH?=
 =?us-ascii?Q?lWqyFrLuAvxrsNan5dwZws0OslBMzz9cHosAFD8jEzecrPHhJjgjXeMt/6Sc?=
 =?us-ascii?Q?DZcgLAyKZRIcsdnQuGDp4pgusJv+q0VFKXJYsutWZAB/KPd5WM/SdVyQrEB2?=
 =?us-ascii?Q?xuGx8B4e1U+GCTK5zHT8ajg7nokfL30CuNIK4TZjznQCGETPTxJndH+gqoKp?=
 =?us-ascii?Q?WcAkdFIVFmXM0nKUHsZ/mB0FtWDPDuJ2cTX7PfZfyZm3AFqfCGvEToUR3gE2?=
 =?us-ascii?Q?s82OID7R5suvrRvoIcwiGdCVGucIAmzBOVzR/uRXdv8XmYVGTLMzYE+WxngF?=
 =?us-ascii?Q?qftUgnuvdy1lfCDZYTjggO3qdp3YeAWyRfR33ELH18FOZUOP6rPq5uakA/6D?=
 =?us-ascii?Q?8y9cCXq73OVNCIYkVuk8QIMqlTLaka6581pPkSuotBcN2CCR78SS6WFhQj4f?=
 =?us-ascii?Q?GNhPkP+bS7j7UTCVrmlsIAMtWUWFcEVhUhw2PvhO1KSroVCYlDC0HbQFxHWf?=
 =?us-ascii?Q?u0btLaDWgCxpGZci/YyngfTPOdgGV0VzEnWGdh9NX1/4BAkBnQEGyN3UhWEp?=
 =?us-ascii?Q?4HMdJPj63Odl1y0J1kNWXsPIZT8gQFEJEKLLkTd0vxj5b4d+5NxNwB5DtAKV?=
 =?us-ascii?Q?MxCNK2KasCUE+hceX5tjA2pmjkGGuY8+wsUoHzexykmRNfoN0Q3/Ox5K7Zo5?=
 =?us-ascii?Q?DmBERUbAr+pKiRuQgTsTppCOV0IpLHvBjsugntgClNV1IDisUhBo9oNariqH?=
 =?us-ascii?Q?/rxbApQ+ydtmw/V2isrLtqOw+O5r5wLJeh8jUZ4scJ6NEys9q583FWome6di?=
 =?us-ascii?Q?yUjDsjYD8JV+ZH8NV2o2rg/zidiuO1xa7cE720roa/Pl4rgZ7/yDW9WnBNUF?=
 =?us-ascii?Q?ZP/aIIzZXk5jrtW65h16LqmyJAYfyZY=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57c95e3-9e79-4a62-5115-08da374be65a
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 14:53:55.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk1MhVC9Era1Cj64MOSea4VCmyVcCcSK+ayJ/qa3yfcXECTjqeDfASevp9vbtsaMAPgFMePjGDhh5j8oG4saCSzQN611Ab3wuZNigxo11so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0391
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:49:12PM +0200, Ahmad Fatoum wrote:
> On 16.05.22 13:58, Max Krummenacher wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>
> > 
> > The STMPE MFD device binding requires the child node to have a fixed
> > name, i.e. with '_', not '-'. Otherwise the stmpe_adc, stmpe_touchscreen
> > drivers will not be probed.
> 
> IMO, the Linux driver should be fixed and the requirement to use a fixed
> node name be dropped from the binding. The driver itself already probes
> by compatible, the node name seems only to be used by the MFD driver to
> detect which functions to enable. It could do the same by checking for
> compatibles. Otherwise you invite a game of cat and mouse, where in
> future, this is changed back again reintroducing the regression..

How would you handle in general such kind of change? Would you keep the
driver probing for both the old name with the `_` and the compatible or
you just break the compatibility?

Francesco

