Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881FD586C34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiHANp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiHANp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:45:56 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30094.outbound.protection.outlook.com [40.107.3.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69603334B;
        Mon,  1 Aug 2022 06:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKyWPs52x2WNDjhrLnBTvaojgWw1WoFohsQjwaxU73wnMmsa3OMVPP7PDwhmhXwRkjEqAQ/NrVhHcLXPOIkXTrXrXuYGTinrUazhuf3brvyhNw0BNQ1g2FLwA/GpMjq+vp97AzPY0vEEAxyfKHDW7KBPijEqOBgUhUmYCPPEqJEJ8D92avibedMS3cNnqDA5G9qDY2of20VdXzxsZZDhlZfnPWU909/1/mquygz2lPDCW5zRCwPEqalTIJ4+n55CGE0acuCripE+YjiCQvF3BJZ4z0V1Y7MZ+PCtXF5+zDHdBG/aX+fcn5CFC+ce8iMXWETvNqlAZpx0sGUjma8AHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C8UZVCHfYPupPZ1oCjnRmcAH9kAHK4HPYfJD/rVC94=;
 b=LQK3ySnuMDOMxOySCEx/e9kfvxP1QKtv14u1rQ6LzF76Q9pfPrK1b2z7AoTi8m1w4JGS7I4gJm6mIq0StZ5zYCEI6wQkJcl2YdB44+b2061hdElEi2KqkFZeHoeHM2pqsaU1w0qEpm2OiAu2nKUSM97DgEeH8YWpmw2if1IVIdFenupHC+sNmNY92ctxeSXv7ovr/Y1sRhpb0ocnG3SZnppd3C/PLR5Fw26hkJXITM2WtMKcUA8hgcxBjqLfKG+5kDr06TBuSPLlAuhHcu9/yUQNqzHJ1w7hFZEBqHewY50DjyaaITJ1PV0a0CcfKtdlXD36z+MftmIpLqAhOq9FiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C8UZVCHfYPupPZ1oCjnRmcAH9kAHK4HPYfJD/rVC94=;
 b=lgYr9LMzmW2sO230+TvGne79/R6RyLSOgNDxWkiC9h+luCPiod9QA0sppMpy65/+Ynfxmj8NdxlNEPq07Hs0Dsp2TzYmWIZTI5YyqbLm6bCzdlnY8WT5pTjhM+b9+N8bZfPBitxchog/7i0equ7XOZ/wMiCMKRNAJulKvjJiMMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB2318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:84::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 13:45:53 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cd6:567b:46d0:a1a8%8]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 13:45:53 +0000
Message-ID: <16f688e9-7777-c5f1-0269-f83ed6788831@kontron.de>
Date:   Mon, 1 Aug 2022 15:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/8] dt-bindings: regulator: pca9450: Allow arbitrary
 regulator names
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
References: <20220801131554.116795-1-frieder@fris.de>
 <20220801131554.116795-3-frieder@fris.de> <YufTP621Bsu8HVpP@sirena.org.uk>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <YufTP621Bsu8HVpP@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0104.eurprd02.prod.outlook.com
 (2603:10a6:208:154::45) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03d55182-a95d-42d6-5c19-08da73c4271a
X-MS-TrafficTypeDiagnostic: VI1PR10MB2318:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVXKOEueTAeb6Nj4BtkHlLzdT4zzlTfd2OlBZHaszvNsZG0C0v3+byYFZWr/6Hf23RAeAkHZziF2UJoQCvRIVWpDqEj59c0Pj1CiAT39GmXx/0Xpx8iHFoobyigj2jhel0UtPYwtMsaTWVsR/wYc+VnH26vE62HpJ70UIPj/QYGFtYw3d7uCHwKg68CgoeeVrdt4TxgsjLy8+M34KXurONT8b6l4Oc9IGxh+Vo0VDakNJ0kh3u3zDhao1EwpnVtz/uz2y4am17/ZRxKbqEU/29diuMVekTrUDtRklKyCl7XKtrRwVoLs/KBA2LZ93JF/WRrOKbZwzWc5D0DAkqYycdWa7qJIM8qch0rvd/L/dnnksSGXoPqiAkGSgO9M7qb6qeC9fanMA2RulQdYZobHUnPwYN3yp4CAk4isJ8bhZUsfq6CtF9rqdAm1gAiro5TuIt3mOq//RKSGhs61KccveYbqjZINHUC1uMdFYEyntD91yZZ8CiobD9JCk9JmwkJWgdASNMBypfDFiJVws+w+vSDLyAwPbs7LKG3NRbwRe5n7Lx6IYHYmzJt9aHgulaX/eEdu6kBcJ0ewaw0QtMOR+oNmmqL2vCu7aviRF+ngLqPmDoTeJjc243W6OPrQ51BehJf0HkFgwINDi4UyY06Dnl91zhtRjbvD3I3gujnPPAZx6LO6CFVbTkLsOoS8mIP03H9zrLCis2VTZZbVe6wQ9p05yb5MIHXL1CzxS+T+BSeWDDNU/LYN7wr3la2Au5J9MxKAblVtPn5QTUYk5nxzWpHXSktQfKZiRRTBYi3tGXuQSmQsW6m9m9Cla0zOkAC5NR1yt6ruaFkEA4oe5orlUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(31686004)(478600001)(31696002)(36756003)(26005)(6486002)(110136005)(8936002)(38100700002)(6512007)(54906003)(44832011)(5660300002)(316002)(186003)(66476007)(6506007)(7416002)(66946007)(66556008)(2616005)(2906002)(86362001)(41300700001)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkw1WmRIWHdlVk55L2JHRTUya2tDQ1UvRmdWbjYvVGhSSWJDdnFneDY2Sm1W?=
 =?utf-8?B?S1hab0FqOTMza0FXWkJEZ2lkZExENXZzQTBSL0xKMittOVdZY05abWJQV2RU?=
 =?utf-8?B?c0hUYk9FU0FrNFZtQW1pWHZHaGhPQnVqSWpsZXNHelhQZ0UwR1o4aTU0WHhD?=
 =?utf-8?B?M2xBdzJGSURUVHVmMXcwUHl6SXE2Y2R0RXpVZzlsU0xLY1NiWTNnSEhJSElL?=
 =?utf-8?B?aCs0eGRsOUMvcEZicXIyQ1EzTWI4aUZUVHlsdDlUeFc0K3N4ZDJDcitsengw?=
 =?utf-8?B?V09ya3dqWGlDS1BvRXVKRnR0czNBeWNuT3pHajBpZm1lcnptVVNFTW1NaGkz?=
 =?utf-8?B?QjcvN1lWeFJZVHEzN29JaUtROG9aVWk5RUxUS2NmY0M4TmpPUlo2ZnVsY1RQ?=
 =?utf-8?B?MHZyekNQcW5leDN1Z0szN3FUSUtyTXdhR2Q2YkFITzlIODM3eXRUYU4yYy9z?=
 =?utf-8?B?UkNxd3V0Q1lYNHFTakF4SW5IRFhsMFQzbzF4K2xreFQvMmpRcTAreThxcWZK?=
 =?utf-8?B?bjhlTFJtU0RiTy9Od0VocDFIQkxHSi95ZCtrWGpDSzZnZHJkemFOaGFXTDBH?=
 =?utf-8?B?bWZ0cldGeWk2aHJocFRRS0srbzNsYk1Nb2hOSUJNRitNZHNZYm5BdzAwRXJo?=
 =?utf-8?B?a1o2YnRsdlB2Sk8vTGovc2NNS2Rpb2tKOGxrbGVYd0M1R0pNeERCTGVUK1dh?=
 =?utf-8?B?Sm5JRUxkbU1VTSsrbHpub1BmTFVFNnNjQ2tZK2ZXMTN0N3NOT3JCMkJuekc5?=
 =?utf-8?B?U2VPSmVPaTVJQXB5Q2RPcEVmTFNuREpiS2c2SWZVSUMrNTYwSXRicnRvcEpG?=
 =?utf-8?B?UVNoeVJLZkhJdXl3UWYxUDhDcGcyRS9lL1ZOYVp6cExvcVR5YTJLVnZlQXdX?=
 =?utf-8?B?VHpCMHA4a2NaL2FLQVNMcDRxN0tpTXMwYXUxMVIxM2VlUlBJaTNjejE3bloy?=
 =?utf-8?B?Z3ppM1Jkem1qNHpJbU85enk4c2ZjL0piS2l3Z3NUdW9kdjNOMzgzMjhSR0RH?=
 =?utf-8?B?NEVGUFNpcWlld0sxSjVKN1YrbHRjVVN2Mi9ZQUZQNktSamIvcHY2aS82clAv?=
 =?utf-8?B?ZSs5ZzNuUmNUNDdKam1YNUJ4SVZUelRjcUlUWktnS216K1BDcXpIa3c5Umpz?=
 =?utf-8?B?YTlYeGI0NTRCU2tMVVl6aUhnY0YrcGsxTlQ4ZDYyajZENjRTTS9NcG1rWGFI?=
 =?utf-8?B?dHpXMERvMUFKYXZZZlNyOHM1VWhwb0l4VlQ5anNTVHhKT0NPT01NR1ZQRDQ4?=
 =?utf-8?B?SWFuUTM4UlVwVjBVNXRtZkhpdlF4M0pmY1RkdGRGUUxwZ0daQWhVWWp5TjRI?=
 =?utf-8?B?M1NRSkVCejlZZ1psUjluQW9sMjlRcTU1QXhHWktoaTdTU29Gem9sSGpNYXJq?=
 =?utf-8?B?eUswdThocjhOUzhIanl4cFVOQ3hvRU9JUitiZkU0ZjIzajR2Z1FmRzA1eWk5?=
 =?utf-8?B?elpzZ09CQm5hVE85cVk5NlQyTFZKbUg4Yis1dWZHSzdlWjJlNElnVjUyN2Vu?=
 =?utf-8?B?TDVEZEs2R285L0t2dWwzaGh6Ym1IWDV0RGtOM1RQcmJiRDBLeDNMcGJScmpL?=
 =?utf-8?B?aGZpY0JOMDl4di9FMHFBNXFGa0ZvbFNhNXM3cXVNRWxYQ3lYTUpLckM4MHdk?=
 =?utf-8?B?VWdULzNJc00zaW9RZFpZMlRhelFrdUJQOVV6bTVnSUJOYmhQSHl4MVlidXph?=
 =?utf-8?B?cnYweEdkM0ZWdWlSNEVxME8wOHZQZWxDcWs1bW5hN3VnWWFMZURXTEVPVm1Y?=
 =?utf-8?B?UXR6bjZjZU1yVWExdTlDNVduUWFkNkdoS3NrMksyK2s5Y2xNemRlcnNTWGNB?=
 =?utf-8?B?OTcvWCt2a2dZNUJmb1NjcWVrdElyZGRkalhhWWRjSVhkVm9QdE9kY3B6dWQr?=
 =?utf-8?B?Y20wYVdmcnRNUlR4cm9QRDlCZEFzR3N5SGVmRzFPd1lyUmpIS1l5VjdCUnlN?=
 =?utf-8?B?UUV3RW12a2hPaUV1SWxEZmtGWDllSFNnVWF3b3N6eWxaTllzMWR3Z3J1MCtZ?=
 =?utf-8?B?c1JJMmxobWNuazNDbC9zQWRYR0pySC9LcTdVVE5MUWZkQTROZnFPVTZrZlRQ?=
 =?utf-8?B?dGNNbDNZdEJHRTZnWC9ienJhZVp0bFV3OUI1SFAwMDhnRkEvRFpIeVlYbFFC?=
 =?utf-8?B?VmExdWRPWFNtemd4UEZ2dk5hL0NLTDk4ZGpJMWFKNGhBVGsreHZqYTBvQ3R2?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d55182-a95d-42d6-5c19-08da73c4271a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 13:45:53.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX2vpWB0PhQt9QRlqTSLnDJbA8kyIRvSyDGDwQakzFTiFihRQdIXBff2doq4MioVSqPL2cn77O3aCLAR9Tkv+eAgDsNBUEC17USZAfTcUMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2318
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.08.22 um 15:21 schrieb Mark Brown:
> On Mon, Aug 01, 2022 at 03:15:46PM +0200, Frieder Schrempf wrote:
> 
>>            regulator-name:
>> -            pattern: "^LDO[1-5]$"
>>              description:
>> -              should be "LDO1", ..., "LDO5"
>> +              Should be "LDO1", ..., "LDO5" or whatever the name of the boards
>> +              voltage rail powered by this regulator is.
> 
> This should simply be removed from the bindings for the device, devices
> have no business placing any constraint on this generic binding.

Ok, IIUC something like below should do then. I can change this in the
next iteration of this series or send it separately if the rest of the
set gets accepted as-is.

--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -47,12 +47,6 @@ properties:
         description:
           Properties for single LDO regulator.

-        properties:
-          regulator-name:
-            pattern: "^LDO[1-5]$"
-            description:
-              should be "LDO1", ..., "LDO5"
-
         unevaluatedProperties: false

       "^BUCK[1-6]$":
@@ -62,11 +56,6 @@ properties:
           Properties for single BUCK regulator.

         properties:
-          regulator-name:
-            pattern: "^BUCK[1-6]$"
-            description:
-              should be "BUCK1", ..., "BUCK6"
-
           nxp,dvs-run-voltage:
             $ref: "/schemas/types.yaml#/definitions/uint32"
             minimum: 600000
