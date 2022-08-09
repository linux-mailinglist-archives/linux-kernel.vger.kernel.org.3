Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D058D997
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiHINqY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Aug 2022 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244080AbiHINqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:46:16 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31DEF13DF8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:46:14 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-4r-ev0zWPXOLJI_GyyY2PA-3; Tue, 09 Aug 2022 15:46:10 +0200
X-MC-Unique: 4r-ev0zWPXOLJI_GyyY2PA-3
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0605.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Tue, 9 Aug 2022 13:46:08 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3510:6f55:f14a:380f%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 13:46:08 +0000
Date:   Tue, 9 Aug 2022 15:46:07 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
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
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: stmpe: Remove node name
 requirement
Message-ID: <20220809134607.GA44926@francesco-nb.int.toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-5-francesco.dolcini@toradex.com>
In-Reply-To: <20220712163345.445811-5-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0190.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::29)
 To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d81d3f-9bfb-431b-07db-08da7a0d8381
X-MS-TrafficTypeDiagnostic: GV0P278MB0605:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: wRLkGdmNuOsmfCqcLnqltpPKjRkrLxWwww3rMIXMmMMBmDja8BhTo5W9QqwUcEu0jadcZpjvZ1CZ/n3gyQ1oAlxlT7j9rogm27ZUA8juShwR4xp64h7guiex0ZuhCTsbDk5RCJX3Yl5WCH7I5V9PgAW86geAPkj+710E3KHyPIDZD5yv11yopl8iRuRA1OyOPplsUIZsI1YyF6a8WA/Fx5D0DCUvdR8eZB572U5PK2pLP8szN5rPPi4zlrUDJdKxqpZJ8KYtWx2cvlq9Rd6kpEaOpdjVnAJbnBVzYiOkN7L0hpsNFQnH3aV5y79Ku3jXcvmPeTpfcJGN3liEYOWLq/05gsQ7GrICH9wJWjWeCTfA2+nYaeNhXP5MTJISXnnzrAHmCfXAPJrzwHEHEC2JDYYrp+hjhwB4vlIvXplrL4XXGDmMr2taGPmgSb79ayKlBBRmqVh69pGNisdJ2OAOEZ61T5O0OSe7u57JvuRMLQ9fi49cw/S7YH+bvb9z/HsxLT2uSUkQhdJ3mONWRWCe60gTaeOK3J2K3lcMl3jK9dsTwZSAyZhhClvnBr5XHZovH5EUq4aDPfWrD7p3qNPUAKKmLCIJY7G6fWk+4B1RrMaMXpoS+85DjAzi8jFQidR1ocRDYTbFXMsdR1P5eqYiRjbxey0DKtr0iqaM+v1CMdG7IJzkhkWLWXBfHC4Dy2z+d7l1gfmhhRo0c8yYtbfLiIxm7v6h+rqUON7teXKghJzBb1aTqdIOi8fV2lJouNiYbCAtQeDmgcFxO3xym/kFxMRgwh0yc/UZrKWfxNB09HeOCHWcgpWTYwZoGXuomTO2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(39840400004)(376002)(6916009)(54906003)(316002)(6486002)(478600001)(41300700001)(2906002)(8676002)(44832011)(66946007)(66556008)(7416002)(66476007)(5660300002)(8936002)(4326008)(38350700002)(38100700002)(6506007)(83380400001)(86362001)(107886003)(186003)(1076003)(33656002)(26005)(52116002)(6512007);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l5qrPkDmaU7Hz7v922JfL9Tr2Yk045VxPFIGuOSq1Pn4zGYSBoDrrwFAe7HQ?=
 =?us-ascii?Q?naBP4tHfCPXViOtmPgPdobbbiOW6FPsB7FFKPuq7YcwpnWoq230t+oHpYvSr?=
 =?us-ascii?Q?ScCg4EuHqj7sz3J8eH1eUpOjftr2tLvd3FZ2vgUshEPYD6rhQxTb0bNBtcBp?=
 =?us-ascii?Q?2l+JINLmXLcz0IkE0kW3kuwhNWlQKNu9wc2tAWiFaN3Zt1I/qHuAXA5imzY7?=
 =?us-ascii?Q?iYgHHCicz6sWYE9dMZLoXZYfsEv5vWj8gvztF++dq505j0Pwliap2NlbpGgM?=
 =?us-ascii?Q?dkM75Yg8qTvf3T2CBL5M+o5g0y2bcxOr5zgmcDuCB/cLZYJhyRIfqbGaBljv?=
 =?us-ascii?Q?wqMhRlp29s4nf6XYNz/+CzrJYt9HmdYZHzxk5daGNSfvKxyEgRpWxQx41Din?=
 =?us-ascii?Q?3EsYDi5FoDi1FqbvxBcTGFH0EUiK9lYOAhJfwc+fREzsgL2dGG+bMd3QrbUf?=
 =?us-ascii?Q?BXxxKBEl0QKQRTF18Nyj9FWcj3Nh4Kb1ziPzrBuqfc/YKyJmpYFo92Px9fa2?=
 =?us-ascii?Q?ZtWKn56pfcRlI5cUDoKLRMFQXWYhb6BcLzDi7qACA6cJPV/OZwzj4cDYnoxq?=
 =?us-ascii?Q?p69NiSG72dR1QatS2+JAAyLPRUDOrT/OFAc9SjXMwzAvSTC0KrW7H42tpTDl?=
 =?us-ascii?Q?nokDIBpY0ZrHOf6NyVpT+SU9UiPsms27WwycE0zpAbavk9f/vILQPA9jVIFO?=
 =?us-ascii?Q?i6pG2lnKu7TJS3zDHmDyH6Re+SW7yYBSXAu65e739155oMaUr6AkBwVTxwXb?=
 =?us-ascii?Q?zYt1WZyKrj5IlpDAwySqaktLCXW9VyvQG+Bu/Jout72qcMM0YP5m0cSqJNR6?=
 =?us-ascii?Q?U7m4G8jP83Ka2CFeSNcIZTm2EABqLdlttBw7cJUflWV0st4OEs8QJqLOzZvC?=
 =?us-ascii?Q?YmUKDlffowgVRnwd9Sd7u6fMrDctojsi5e5GnwBG+UHtDLkG2krfYC2r4LbY?=
 =?us-ascii?Q?qEba97dFb7S2YFiQDgd1jUE2OnmZMTNzwN459XQ0TeNOeARYhAH915/IuMJT?=
 =?us-ascii?Q?0T26mFESe0McspjGgfTuh6dIVQ2WiwGSJY84bdhwJ+/fBtyL9SCuXBrA2qG5?=
 =?us-ascii?Q?3i++FFSuvSC8zNKLfI4lLmtw5uwOOspAbD/jOIKs/wHEPLUy5Mzpbvd0WlvR?=
 =?us-ascii?Q?pEkc8buJMOmxXnuK37PPqHnD68bnuAT/LzmQsDzsj+iEux2m6ZmvujrNg9XM?=
 =?us-ascii?Q?TqwIHZAqx07L8iJQpKAbpnVSfEP4uptMaJKZvfDCDwotmijg8mrG5h9aTjnN?=
 =?us-ascii?Q?yiqM2prGClOx59RxIMRBxJPyfO2d0fvwiGcrVkqxzgb0xw/i5v15Cpf//jYc?=
 =?us-ascii?Q?DM2cs/A1c8usW2U7pzV7MlOkA5fhC8ApWjZ9g8OTKsYcSwtZZSA5E4JJYeq2?=
 =?us-ascii?Q?UG4BMuWvOFe0vUyvBUNMx1ENDuUGalZM/G5dnUaE/4mtalLdfRxhVWrPKn3N?=
 =?us-ascii?Q?2vfBwmdNtks5oYMnp8Eo4I2wXmczEpmlYMyXs1bkkLE+tBuK58ZGOsE9FoGN?=
 =?us-ascii?Q?Mf+Gi87LZqyT2wZlh0vL882Lv6tKb83Vv/B5Azdqk724Ap12uWr9qoKgY1/2?=
 =?us-ascii?Q?9s0umo+CCFsB+SXXbHF+ltqHbYYKfHpxtsv3ThfS7325TNnZqpXigGB8Sm0P?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d81d3f-9bfb-431b-07db-08da7a0d8381
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:46:08.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIspWRULY17GSY/GfvL5cvHAdTxylk/moYOCnLlwfI2ftUFwvleje3vIhJ7W/kxbmtnvZtjL0sO0QNI92PR71jBjWsBY4FeqmroyRUBx7Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0605
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

Hello Jonathan, can you pick this? Patches 1 and 2 were applied to MFD
tree.

Thanks
Francesco

On Tue, Jul 12, 2022 at 06:33:44PM +0200, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> index 9049c699152f..333744a2159c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> @@ -13,8 +13,7 @@ description:
>    This ADC forms part of an ST microelectronics STMPE multifunction device .
>    The ADC is shared with the STMPE touchscreen. As a result some ADC related
>    settings are specified in the parent node.
> -  The node name myst be stmpe_adc and should be a child node of the stmpe node
> -  to which it belongs.
> +  The node should be a child node of the stmpe node to which it belongs.
>  
>  properties:
>    compatible:
> -- 
> 2.25.1
> 

