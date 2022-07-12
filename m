Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1515717EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiGLLDA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiGLLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:02:46 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74EEEAEF48
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:02:43 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-Soh08dhJNdmOHhAbPQBGFQ-2; Tue, 12 Jul 2022 13:02:38 +0200
X-MC-Unique: Soh08dhJNdmOHhAbPQBGFQ-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0317.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:28::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 11:02:35 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 11:02:35 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 2/4] dt-bindings: gpio: stmpe: Remove node name requirement
Date:   Tue, 12 Jul 2022 13:02:30 +0200
Message-ID: <20220712110232.329164-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712110232.329164-1-francesco.dolcini@toradex.com>
References: <20220712110232.329164-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0155.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::18) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f158add-527d-4a5e-dba7-08da63f60654
X-MS-TrafficTypeDiagnostic: ZRAP278MB0317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: uMkbu09aaOxSQZXyTalk0zwNCwMCHY+RS4Hoc5AIc94aT/tzpynO+orykNJP8t2JTviqNbWeU2aFkggIplhLcUnVUBM9Df36nAVLC5mCxVLyw3jII/KlFIBFqvfYlooK3qbOjXBGJq4YRGltcwIFluK4iQVUVD704ESlSaL28CWN+5aTt3g0R9I3AQXpEByaPdE36zrkm+PRL5aVuG7S3tHt14Vw6wcp1SqHhrz22YDpyiD3xdqpi1qlcayfMOBXnxvQJ/REy99jY+jlCozKxPX0IqNQLXg4vHszaU9N52ql2119wggkh1JdkyuLPhRum+AS2hrS9dsJGyk90GZW1LLUbollSOdwV7q7YHdnYc8330LwTr/yEl6k/WE0bk0F3dnxO7P96DQq8vZoYExcgs1sm8vuOY/brArG6L+wDe3KxRi0ELYMqDocss5FxZ9NJA29BpGQE0SHaFs3HKoYGzjQ+MGynixeDJ0TeRxYqYBlRezMWgp+CiclSYOttx8KCqJQkTyYiLqR0dqNTKjP0zJBnCMxwtpnNPrnU0eCpmAG/2MYSizzOdJcIxYG1Nj8V5oGT+W04aBvc/9vGlvR8NFkSwBNytSIIjVQ9VhU5abpyEBop6uERPqZMzhznIu8J+TBOOBews4d/jykzZW4ERP1LxbeXfQzpzcWxz5Yrpf6xj8AG2tzt9doklF++KBYopg3x3KcaKaRIZpuKFfctlkjEC6sYhNMpxjYvdz8/h4Xs0J9pNUjosL53AeMFNWIfFoUxfs0Y8L4qfaAM1wFyn+iWrAPwasg70JPmc53erbCbkyZlZFe49DEAiqBQO+d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(66476007)(38350700002)(1076003)(52116002)(41300700001)(4744005)(38100700002)(2906002)(186003)(6506007)(6666004)(44832011)(36756003)(7416002)(66946007)(316002)(110136005)(8936002)(478600001)(5660300002)(26005)(86362001)(83380400001)(66556008)(8676002)(2616005)(6486002)(6512007)(4326008);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f10A0wUk11um4FCE20imVuAJGKLLyqJqUi57TUsLPQky10pHv7/xORcJftUI?=
 =?us-ascii?Q?cNJsnJKWMMm2r1T0DnkxLrYgkRTK7T3hrL7tk8TaOaW9OuND/gs7+EPhrCn2?=
 =?us-ascii?Q?sFvXojvTF5A9oWIrSsClADN76eCxSzquFf+nyzhmQfc/t72qpIPk4rjEPtRZ?=
 =?us-ascii?Q?ipUbDpzp9oust3wF1sPs2/UpO/46Q421aoaCu9QcwklubLFmfBAz/r0YSTMt?=
 =?us-ascii?Q?rwaGp/5mhrlO855NrY9FbtFW8vwogGdkZ/mb0mHS+iFcx8TMTLEwRMCA2Fo8?=
 =?us-ascii?Q?Yt0uxm89Ourn+Bmuwi9XzKFXCmqzuzdv9NV6kULTKlplD6dsM4AJWIG2xpoV?=
 =?us-ascii?Q?uXHud3Ea9QrL8rRPsM7/wdQLUED1JJA6fSGboN1SUITHA4dO295S4ampbDNd?=
 =?us-ascii?Q?13N3M+nduS7YhjDfgBRfGKuF+zKRGDz9q4dP8Wsqycpe5stmnDYM7bjtWu//?=
 =?us-ascii?Q?l+7kWquIUcoDbjVZzEsSLZvTxFwTrN/vxOvuacDZnJnvACDxBNfSKiHt6r/N?=
 =?us-ascii?Q?3ViYkHvfjyENg8BvJDu/piUkcWgAW8++VSqipvGU3dWFZ6yCIxS6g2oFwUAt?=
 =?us-ascii?Q?hhTEWEEu8veOmvpMO2SN9OJIrwIm6ZJB1Z7ylw0RDVR5+avMxDJgWfE9ZmZ1?=
 =?us-ascii?Q?ND0Ao1catLw49aNUfrSBtqjtxNAB5fzTTmaPF/LUziuUfQVIid901oQQNmRM?=
 =?us-ascii?Q?PmZEUTo2SErivg32nwUN5ZfGxW3NlGPvOcfhH6GWEhoPs2jWm8nMMFm/IxuI?=
 =?us-ascii?Q?H7VHxZnx/RTutQPwQL96n9NZyBarCHSYNIFkTXpIjDiJxNYSUgOJa/YJObtp?=
 =?us-ascii?Q?guWrCMZRozpKQUxnRx2r92L6jnmwcgL13LifQZtwCxsZwqU/vD8U/aSbr0hB?=
 =?us-ascii?Q?kN+2GTwCzzIFoUnIV5A8BIpG0jgJrz5fXqxL+uDGy7QXNVgcb54m7qQgH9j4?=
 =?us-ascii?Q?ciyUTf5I0bOpFfc/Lv4oQK+yT2wngsUrT8/ug26YMo2j0c6oovM8jOUx/TSu?=
 =?us-ascii?Q?ioORuSXwtD/eieQnM/AZhcps0u5WwF26EkiR5nY4kcSchUb0t7T6Luf/E3Qi?=
 =?us-ascii?Q?BxLjIHQDCelTG5SyAns2tRTfL/hPU3q37tJlhsMv7YGzC8gd4sLtIgRC6hqg?=
 =?us-ascii?Q?e84xJdYiDBcyIF8i+fCshdyivNvkQ2o5f1XDsMHS1vTQw9pWZchKQG4IvTBG?=
 =?us-ascii?Q?6v06kuLYodBC1F6lTqOD31gUDsaDRb9OyMYRqJuln5a0aBbJBjTYqOrE4Ib2?=
 =?us-ascii?Q?vFDIu2FjADN1lhjsYk/tQMwZdEHts5JwK2leW06bj9LJQUMmIAGQTGW5x/Y5?=
 =?us-ascii?Q?nn4XsWNKKhjd3Uz/3DIEUWmiDflLre5VFwyu/1oH1C9a/IKR1s4mOiLCLw3K?=
 =?us-ascii?Q?vfqfzzLbFy2Y9XbrsDgl0jyLqttt8nuw3y46woXMvPNzxC6HgbRzvx2YKrcB?=
 =?us-ascii?Q?zgA0K5ixRuBegKI9A1mHEtcUy7IK1pKd8Aq4aZhb2it5Cz1rUlgJNhJDCDkm?=
 =?us-ascii?Q?AhZrk6miwuV8OJMTzB88mLpp1YQQN1VrJAsKlgWQZvDFHKZhr6bUIFQYJopO?=
 =?us-ascii?Q?hAUF0FVcD4UpRe2PhSsbbPvpZTtrALLUfcQw368vhfgqHFtmpw2IQhmNZa0R?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f158add-527d-4a5e-dba7-08da63f60654
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 11:02:34.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jR8ROypVvsKtSoe3wCCbEMSxGQ2MuC64Kyl8UqpuEDFgNLsmVLu2HfBcleU0p8cF9F6hAU/UKwni679gj4eRGH5/yOC03bQlDuuTSnHtyrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0317
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STMPE driver does not require a specific node name anymore, only the
compatible is checked, update binding according to this.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/gpio/gpio-stmpe.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
index a0e4cf885213..b33f8f02c0d7 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
@@ -8,8 +8,7 @@ Optional properties:
  - st,norequest-mask: bitmask specifying which GPIOs should _not_ be requestable
    due to different usage (e.g. touch, keypad)
 
-Node name must be stmpe_gpio and should be child node of stmpe node to which it
-belongs.
+Node should be child node of stmpe node to which it belongs.
 
 Example:
 	stmpe_gpio {
-- 
2.25.1

