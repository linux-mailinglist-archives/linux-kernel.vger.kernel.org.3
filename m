Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10705ACC36
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiIEH1M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Sep 2022 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiIEH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:26:49 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE9BC18
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:24:37 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-45-Xuy4fWX6MpeOuEZGFQC6IA-2; Mon, 05 Sep 2022 09:22:19 +0200
X-MC-Unique: Xuy4fWX6MpeOuEZGFQC6IA-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB0758.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Mon, 5 Sep 2022 07:22:18 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 07:22:17 +0000
Date:   Mon, 5 Sep 2022 09:22:16 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 5/5] dt-bindings: input: touchscreen: stmpe: Remove
 node name requirement
Message-ID: <20220905072216.GA6496@francesco-nb.int.toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-6-francesco.dolcini@toradex.com>
In-Reply-To: <20220712163345.445811-6-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0133.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::18) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8795ca12-5361-45da-5f93-08da8f0f5d43
X-MS-TrafficTypeDiagnostic: ZR0P278MB0758:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: IZFINbnydV+tfarHSvJrhsU2qdskQ8S2O2wFg7LmCrRxeE4TR1whdnh8r86nVn3rWRBDPWs9qO+t0uSIkD2UM22531wA/d/dVbvh5NfFKmH08uMgqxwFI/prIIh78jVuykcR+UHi2b94/WeHvOE+mC5/x4czPDz4vzO4+ptKvKDCWujEZJfHD6Z+ydbp8W7xCS3BvpTSxWWZoTM7w/vWO+UsVMYs6VxtIO681pEhuIPo9+ycPVy3ockVUfaSh4FOanbtXt1fbxOv/GzZS/vm3lhP7XzYPqs1aA7wtvwif1Dj0qpkdSN+7ES97tD8GObUiQqTmIvNr/B6mIydoV+sFK+5CpKWdhtAPcdpqY4F9f9EMGDIJ+XfLM5UNaXGWJId0sx724YqY0AdXqFSzAiENOriToGAH5ihKVgehaDRTJnOWSazsT6Ob2GFph9Okq3oIs+sjpRzFqeRJWe+KX++VNdBwffdGMHYifmP6dHaPDF3xXoSeJCXzNYDI0ihYURBN41pi6wZ2k0nFcH5jJCePYHM15ZaZYCe8C+5vcxmvAcL6r/wl8quwGJOx0XbqVPILPkifrYM8S+Lw8Oow46cePDnmUY9bLVP2APAxXoioAZShiPiUhq6UcMicMQSbX+rf8eRZyVF7CtnVc1yI1JnOZKqg9z5FevRl9OuvMH/ExHsf/qmftnmbgyobX28piCTxS7zH16FyKZbKxiQCAB6PbSIcOTzzeczWrd3MtSF39GhniGIM176R98XpEju35um5slquZIIOcvX8mP42RoLQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39830400003)(396003)(366004)(346002)(2906002)(66556008)(8676002)(66946007)(66476007)(54906003)(4326008)(7416002)(4744005)(6916009)(44832011)(5660300002)(8936002)(33656002)(316002)(6486002)(478600001)(41300700001)(6512007)(186003)(1076003)(107886003)(38100700002)(52116002)(6506007)(83380400001)(26005)(86362001)(38350700002);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzqCutbkbZUFKoXaBa85Qfkm9vxwTyqkw5SkzGwEF1nFUhWTnhBxZAMwWVeA?=
 =?us-ascii?Q?NpvvKr2dCFdy9/11y34yx/e549h/Bj2WfnUlTQvtXNb3WOtDPIZccBh47Xhp?=
 =?us-ascii?Q?ZCMZhlB+SYH/Zs9D0ThJdSD8TGDXJIFdhEaMc9Drmqas14T8ckphOaixeS7a?=
 =?us-ascii?Q?CHBlMM1623cHGemuZ9AInaXJ68wPjBV7ij/OjijQRt1lEnkfitZqKNX4nrew?=
 =?us-ascii?Q?CWzGfxYSjKH6+zG0HaW8P/MGmgY5coioOwQTwD/z5JeYp9t+ZppSkJOz4C+W?=
 =?us-ascii?Q?hMGMS16bEFUKjGwM9o6b51vF1jmU50ClfaIONgUu5xc6lo7rcd/RaCnF+mhb?=
 =?us-ascii?Q?nS6O+ArbUbf20FB5M9Z12Wu9piYJ4xYKGMNwlAWrAbVS1aH2/qpw//iWQJNa?=
 =?us-ascii?Q?/2k7QWXhdhQvVQJeEiiLgIy7Yrf/ss2lqoVTBK9918iXsvUMO2Puv8GgQvoC?=
 =?us-ascii?Q?bF0iTz3mxe8p834s8GrPvOirjARKCJUGg75cpEkIiovXlFPM17lN+Roaug39?=
 =?us-ascii?Q?JWQK3XSAj3G+iHZIl8u2WhNtFW9FwWJXh3EiNqryh60JTdnk2/+OfvMNaicG?=
 =?us-ascii?Q?emK+Qz79c7fAW1Dg5nEgsizTqBeYzjFdv77ABL+RQW4zjcKMii8kh3YW8u7B?=
 =?us-ascii?Q?h7XEv4FZxIYr8OFYxeTq+qc+NKsl0g0su3At2yS1i+jFP2XaOyrAC+da5nyY?=
 =?us-ascii?Q?pMST+gW+M+4eLiRtyLlQ3d2ASv1dex1f8U6Sj1YP3PTpBtSvgJhei7dxviRT?=
 =?us-ascii?Q?SapgzAVpGzI0MzGs23tLoIS9ExRDdIHeX4Mq9kkQYjN95PTNhkfoXDeNK+ky?=
 =?us-ascii?Q?NN5GrAIo6DtvUMgbGMIquuhcTmLkhDNjHKnZn2PepJzcbriRzogb5tYSxzsY?=
 =?us-ascii?Q?QIasS9jxw0qljM36Qs9OQT8Kr4yBtjVbkIRzyrT3vTYGTBrorPj8EmlR7cyC?=
 =?us-ascii?Q?8KGAbQKQ6aa7m7ngPOmW/g6Ky16yZ5+M8VNJQtuUlnPElABb/JmzqQAqgXOl?=
 =?us-ascii?Q?DwjcSXKrGw2Rf2id6nQ6o6v1Cf0OttQ6PDyJ6m5IV9s2detHAsUELu86hm+I?=
 =?us-ascii?Q?RgnnOsfKe3FWwVHP6B85Fc99dNKP58m6M74cudnbp2HwiRlD5zfyn+Bx+dAt?=
 =?us-ascii?Q?elVoLhAO06zL2tWYiPTRh17hFePDRx9YHjt7ODnzS6wx84GDUEymqCDJHpbi?=
 =?us-ascii?Q?lZTQuQpRc2p9S5K+CkLBdbuKJ+QTNFuLj0Qq9MfYG7EIHyif111pL0rFlwRs?=
 =?us-ascii?Q?X0gbSiqSHsOnKV+ACw9lCY34G6BpF/fhEzEFWJdhHy2TfgN8HiGeLmNSp8tu?=
 =?us-ascii?Q?8+8/2OMOpS9dF9kQyu5CsoZZvzmJsKIPTwxRqMMqRCjSjudqjFmn+a2HdcAo?=
 =?us-ascii?Q?kayyFjuadRACHULGNFS2Lh0ofIGEQ+m2NiZMU4XTH4nwuMOMbTnWilWdZRmf?=
 =?us-ascii?Q?HW/uu2LllKckdqWXVyMWY+g4G2AVUE8oN05K/fBosAs+aDYbZtPajf9CPSQe?=
 =?us-ascii?Q?uTNP5O0tt+yD+U2z6cOt0hQ6C6bQStOG/+6d7jalBbAfEQ7RfEGFcLbNBYrm?=
 =?us-ascii?Q?DK+AWRZvlME7N3V4CgwuFWNAxw4S17jX8FFr9OxWq/TszeFox354WhWS4xXI?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8795ca12-5361-45da-5f93-08da8f0f5d43
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 07:22:17.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQNHazLp87XMrMuDQD2HLCc66gyAjVLin2V426cRgUZfKpkNUNOxS9aCwZI1udGTxzqL9nboAA+/Zz3kN80Q2kWnWELRULAl+50kcqpwTfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0758
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Tue, Jul 12, 2022 at 06:33:45PM +0200, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Just a gently ping, this is the last patch of this series not merged, all
the rest was merged through the respective subsystems. Can you merge it?

Thanks,
Francesco

