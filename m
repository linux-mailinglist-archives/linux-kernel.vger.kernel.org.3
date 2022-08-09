Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530C458DC25
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbiHIQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243719AbiHIQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:34:48 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2124.outbound.protection.outlook.com [40.107.105.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775E1E3FC;
        Tue,  9 Aug 2022 09:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJtX84A7B1uK+oYOLlpJX5FDCCisFNFJ8ekrTmvQWbEHRGraqqmAfMhR4t1ynEcHzXbMxQHOpHTtmbSkwhF5BzK0zGvBZTgbS+ZrHB7ehtxsrrGRrlL1tt0lq2rOyccRL703WQKGqnBAZ+mHxL51pBkfRwNQlXqKKtp3sr9tjKvCRuGnR1Prf9y/oe0w4WD4xoeHrtDZyD2Yln6u/Ze4sA/jMlcKhgxPqkZfsCntPFrxyA2RFRjtRfwx3hPVYHH4iohPz+mQrbQ1o3x2P7b1xSrWkjQpgfOEcPitQW9IMY+nGVHQ3Xva2KpwzMpUJeXWgGZEFJUBpSdfBKxzFlRhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+vgawuUOHcIoyJNMrrr2x2hE6iRP6w0vVWROsNH0IA=;
 b=eQERaNWjkiEpPEUEc5d0oH36awl0rgWtSsJyDT4ddPa65gjo94sq/QfRcnA/LG6xYczMpAmhMLwuoTJSDnI34XUTaMtOrcaS6KIq2l+MrZe90ToAB9fovyYCP88GMOarICuEnl1aSyfTovDJacgvwBnOorWvkYr3y7RVpeSij+iL4IJ/2jpY3C+Y6emzWEJsngxBl9+eiP2Ib8mQAobUqRnmdMIFqNqLy1yDsDtRH7yZLt8w6Fwm1Kasga1S1lJRZmlMvvDzhppHI5ioxkAUEOsnBempUwanAq8SUzIuaAzzaltvfC9DyLiSyGd9DwB/DvGIAYV1JToDcZG2vntQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+vgawuUOHcIoyJNMrrr2x2hE6iRP6w0vVWROsNH0IA=;
 b=DoQohTG6wh5zeO/XRI1JbVBcEnweJ1TQvxjMbpCOziypI5z0ckxrip1CdrI5Plebxgyjz03x4Qc6QxinUfVDKU7RC555y9j+t32wKNqDo+RIbW9xU77XLIia2b7LTxR9J1VFMatz29oxkj0CyWnd6vYxLBL3YviiJQsRK4oPnR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB6304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 16:34:44 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8%7]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 16:34:44 +0000
Message-ID: <1af9295f-3b50-bd7e-bd60-429de7fcc308@kontron.de>
Date:   Tue, 9 Aug 2022 18:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] dt-bindings: arm: fsl: imx6ul-kontron: Update
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
References: <20220809152534.292034-1-frieder@fris.de>
 <20220809152534.292034-2-frieder@fris.de>
 <2ac37c3e-fcb1-2e48-bc7b-549d745be1d9@linaro.org>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <2ac37c3e-fcb1-2e48-bc7b-549d745be1d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0129.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::26) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2d1606-bafd-44ef-a87e-08da7a25111d
X-MS-TrafficTypeDiagnostic: AS4PR10MB6304:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqmTjX37ApfXoOupF03Wtn8x9mOL+NvdjnHCvUMvUpO7A8xviJ1jaAaPgSEpY+TbL2E90gnQvgVSAHFyglSVMnIp15IUs8FvRjDSHslGshvS4C/4ndrdqprHN1TZJBOVPXwZ9/Mdjgz4vJP/0xJov/1EDS0cX7G+2xRTFRLFMuLPtVMJ5D7SbXJpTpmoXoWfiqeOR8OUw1O+KLpoREg8ejQWanrDFgtm7IzA8h07NKrfqzldgH5b38dgJ1T6XdVle4jLatPbgDgM3Mxy/5PisARwFoZtc5XrqtuZ6U9JPLXbHG2hp37LTajbJCSaLeV35RDjiidw8hPMiUEDcnMAWGN/6dfDKK5uYNVcrxIJKemGwh3ewf0gIx69OXC9ius6YHof/Z5izUoCam5X3S3mYJAW68ImgU4/botNR+7Rh52mlVPqucUifS/ifYYeLtwIW/sNXwWkuzQvQcPWNnTwJaAOY1VbSWvJWN0fMBICgZ8N6cjXlVey3n+LEMqPfHrdl9+Ey/QcC5pKohBAvr67P5CFRZItNjWk1YEdHNDOc1G6ulxZNALibAbxmLtFY7zaGmCT5zvf2wUSelTZCn4I0mv4nDHUztfLeHVgwz3LfROVRkFXtzrF76iT/gsbLxhu7fsOzVzE3HztbD+hSV6LXqQP/vlQmXM9IaGaSSgly1DpTaH4+9fykqo2JJLGNxAgo39HN6VeNRddz32pIUhtDLG5p6xuHFzO7l8kLRsuFdF+lU0+aOKvvzOf8t+w0au1NFoRO98KjIkbtftvxe/sPADKVnTY7UGFMtDFWm8tKTEzIbsJuDmoh6iIf0GM0dbtFWolIBxtbUpssX9DFvAjAbbeb7ZYENBTDMf0HqX9muY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(31686004)(54906003)(110136005)(316002)(83380400001)(66476007)(4326008)(66556008)(31696002)(66946007)(8676002)(36756003)(6486002)(478600001)(7416002)(8936002)(5660300002)(2906002)(86362001)(15650500001)(38100700002)(6506007)(44832011)(53546011)(41300700001)(2616005)(6512007)(186003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVF2b3FZYlo1NWJteWxmL0JBK0RyUUlra29SNEZqb1Q2dFBOTVMxb3FUZElT?=
 =?utf-8?B?M283OFFIOVNZTkdkYTExclR6OWxSajArRDFFa2tpTkxGV01uWG1MSGNUMnJ5?=
 =?utf-8?B?Q0FQYVBENUNGc01YZFl4Ylp1dEU1aXNEalBjdmY1OHkwYVlTNGpMMktyYmJS?=
 =?utf-8?B?STNNNmZabVNIQjFFV3FZL2hDaTR1ZCt1RTRNaVVnam9ESHF4ckk2NGRSbmox?=
 =?utf-8?B?TmdxdlBaVnJRVndYeEVGaXMxbE9sN2hEbkFIQVJFWFVDTk0zOEt3dXcrWlR3?=
 =?utf-8?B?MW9yUXZlQkcyZURqRVpDTytBZWZJdzZrbHVGekUvaDZvcG8zWG4vZVJna1ZC?=
 =?utf-8?B?dDVHR2pHTUlCYmEyQ0oraklqTm9WZGx5Y0l2ZkV3bWQ3eHBLb3JOTlhVTk5O?=
 =?utf-8?B?K3l0Y2ZIYytOdUpKRGNlNTJza2k5UzlZM3JoWURrVWR4NStJQlhJTDFxbGgr?=
 =?utf-8?B?OGVMRFFnY3RSQnZRSFR4WWQ3RlRnTEd6Mys4cENkV3VTOTZ4WW1DcmtWeDVM?=
 =?utf-8?B?RlVXT3l0anc4aXJESnpCbnVtVm9oMVZvY09ZeGVqZGdaTU5wVE5MOWoxblVo?=
 =?utf-8?B?R1NKakJYVlBNMUVrakJ0OTZGWkhxZ0xWd050RjVFdUpuMVl0LzMzRWQybW9l?=
 =?utf-8?B?TGxlVUdFa2dndldPRUwyT2R0QWFxdDN3T3hLK2JwSWxkYzdNU21NdVpjTVVD?=
 =?utf-8?B?YWVTM0lJbXBIYUFxYVdLT3R6Kzc5OVZjL2lLUGEvM3FadTZFNWFnblBmOG1R?=
 =?utf-8?B?ZWMrSTY2Y1RUV25NR3RzZndyZTcyNGl5Y0VEbW01c2Q5TG5hT3JRUWRMdWQ0?=
 =?utf-8?B?UGNTTE9oaWllUm52WDZrVjNXNlpON09ETDNGaG9SZko0WStpUmNUcUlJTHZr?=
 =?utf-8?B?M0NqY0FvZDkzbVJmdXRBTk0zWGIrYzZvT2FDd1R2dkp0SmcvcWxGVExoaDd6?=
 =?utf-8?B?ZXFBNW9EMVV4RDRxd1BQUVZIRXF2QU8xbHRSZ2ZsZmRWQkY4SjFUaEthZ2xs?=
 =?utf-8?B?Nm9MS1hNdEpMSkZjK1pZaFYySE1EL0ZOYysyTHRvd0RPQTN3RUhsMWZ2eE1r?=
 =?utf-8?B?K25LV1ljenVOcDdXelJ5c05takVEaUM1S1N4ZmpaZTVjQ2thZ0V0QzJ3SGdR?=
 =?utf-8?B?bnJROVYrN1MzREVORDZmT0pkZ3JIRXBmSlBHc1JXUHpKVUlGRVRKTDdTcWdD?=
 =?utf-8?B?ejh0UDIzWFhrdDBlYTRQc2dQSm52VG10MjN1RzdTK2VXV0RabHVBQ3EwUFpl?=
 =?utf-8?B?dWlSc2srY3VEVmptNVpRM2Z6THZOTjNsNlExdXRjTlJYQm44Z2RjZkxFeGht?=
 =?utf-8?B?cTE5U1ZOdmJ5RWQrVDRldGgvbWd1dStyckRTT3BCSlg1NzFYVFVpTmIyWExs?=
 =?utf-8?B?TmRtZmJ1MHlZQlNpcWRKSnlVYVN2M3hYL0xTOUpwcmpKZDNCV0dIZnJOMW5y?=
 =?utf-8?B?TzlNanVJdFJSeVJjYVdOWUpYbGdybmMyVTh1Y2FWTWh1eDA0a3FPUE9jeDBp?=
 =?utf-8?B?YkdRU095RGNabWVyWmtvZ29rWHVjN2QrR1gwSS9lL3AyTmNPNmpXQTBrMk5Q?=
 =?utf-8?B?d0xocGtZRjZ2cG1iUzlKaHVxbkpVaytDNk12bDcwS0wweTY4blM4NmNueG1Q?=
 =?utf-8?B?Nkd6YTlsdWFSNTJYemY1dmhZeUF3bUUxMnd6MndTeUdYcXBMLyt3NUxvZG9O?=
 =?utf-8?B?RHlFcG1CL0FWN0ZRc1lGTURHWndtOGhaQlpFS0RXbVJRakxKbStsa3Bxa2c1?=
 =?utf-8?B?c3lRNzZkWjNaMlJlNXNsQkZaajBNSEdvandaUTRKU1NmVk1JKzk0dENwdHBn?=
 =?utf-8?B?Q3VCcGFydkEzQUJMR3I5VFB3UXVoRm56NTlPYVB4VHloY3RLcjVBWkZzdzRR?=
 =?utf-8?B?cUZKTStPU2VWU0lDOG9hMlZhUzZ4LzliWlJmT3V0Z2ZOWUh0K3duQ2VRUS9l?=
 =?utf-8?B?Vy9GL1ovM0ZycHUzZHdaenNwYmNQL2cxRXRJK2E5bUsxWTQ5TzZVY3BMY1Y5?=
 =?utf-8?B?QnEraThVQnJOalRNb1pXWTU4WTg3cUFCWnY5VmFVdkNYeWxITW9yQmx1RmVy?=
 =?utf-8?B?M3RlNUhmYmlkZWFTL0dkUDRwY3FRWE0vMHFzaS9UVm5QdDRXcHprZm1mdUNP?=
 =?utf-8?B?dUowWjZqTDdqaU5XQkRpZnNteW5NdUw1VzJBaC83dDI1aWp2UFhyYU5hVEpU?=
 =?utf-8?Q?/P+xIxE6XOcZKcn9yJcXn8wEhr99TOIj658PeniWn4K3?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2d1606-bafd-44ef-a87e-08da7a25111d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:34:44.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AwYAgkldlxwT9ttZcNS7dxm4Io7C9jyM8Uo0slhVt6Jc4hqrrCPVv2GhoK5n0wernfz7vvWSrFaQ86kZlaDRmp2/Jv13d3/P1nd0qn6Q6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6304
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.08.22 um 17:55 schrieb Krzysztof Kozlowski:
> On 09/08/2022 18:25, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> This updates the bindings in order to simplify the devicetree
>> structure and to add names for the boards that follow the latest
>> convention used by Kontron marketing.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  .../devicetree/bindings/arm/fsl.yaml          | 31 +++++++------------
>>  1 file changed, 12 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index ef524378d449..7c4c27d553ec 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -553,8 +553,7 @@ properties:
>>                - engicam,imx6ul-isiot      # Engicam Is.IoT MX6UL eMMC/NAND Starter kit
>>                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
>>                - karo,imx6ul-tx6ul         # Ka-Ro electronics TXUL-0010 Module
>> -              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
>> -              - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
>> +              - kontron,imx6ul-n631x-som  # Kontron SL i.MX6UL (N631X SOM)
> 
> Although board-level compatibles are not that important, yet still they
> follow the same rules as other DT bindings: no wildcards for compatibles.
> 
> Therefore the change is not correct, in my opinion.

Ok, I see your point. I will look for a way to get rid of the wildcard
in the compatible. Either by keeping the old names and having some
duplication in the devicetree files or by renaming the compatibles
altogether, as the N6xxx notation is not used nowadays anyway.
