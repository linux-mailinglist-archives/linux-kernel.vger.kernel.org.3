Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4659BAE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiHVIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiHVIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:04:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208E2B1B7;
        Mon, 22 Aug 2022 01:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTZu5/zUUh7VMTytNqEiEfhGNHCIWSvF2fdTTHcxvi2E4Pgqo+01m+GRHQmPZum5EGZtyX9aE5od9tpgHhbDuXS9BAmRzIUgs40sdZeRXj6FejQcfKSgZhkqa32SzV1ppaWwxJYJE2YMRxeTWXOAcD/1QSTMiDJloj7SWFh8xP6NYKHfuPxQWNic0DIBzRFRAJjyX0rG/ae+IPYd79M48flQF0BrjWOfz3X11yB8GHQbwkhLSVUgwcyBnl/sZf6x5hGXLB377izPbylxK5Nf9PYTmVBL9sAKUGudwTWI8NflnNxXce9wWWIpJTDs/fFVDm7bjJVRuMrDScXytZ1FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywkVGiUnXqA5GLWFURlx+VtmemPXpkNlyttJwPHiGUk=;
 b=k6bcyhz03oLNhF2zvoFiC0Xb8/zMvNxZuGR8saDtOQ3pEtcjZIJ7HTPFDMYZ+MxIkRJ0FFbU8UVONDUZpbb7LKKC8w7Jw3v9v5/GM29YpwpMVNY9ccN6gxORty/7Zn33fthYpMZ/GH7uupLUMA7HGYZQ4V+gy/j9DShHUyTF7qvo++6LOf32p5XfZd7KiN9hDnU0yTrc2Ln75vu67YSmqJWOD2USgdigKGDpPAMWMRyCFaTs9wbdgE7RfX9fov6NyI6dVHO2ltkTEyEGt52HMQoK7wwoAn1x7NCYA+y2hVpHVlYS5Ae/lVkyKc1t0pvqc9Tv8J0gaZPi6W0LytAYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywkVGiUnXqA5GLWFURlx+VtmemPXpkNlyttJwPHiGUk=;
 b=MqSBAraOhDSjSv6yWnBX8t3hxveC5bAaS/oohQTCUQVzHVFRkPlxKi9KJiWUUIV1zF10ptpko1gYEqW9G3Lgr7i/DUnqofD4euAFJuhHwwgst5YRRDhsx5hWvR6iu+PWHt8kI8JsVg/iLRGZoAfhqYMHxvDj2cOMGeQO0nQs15A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB4645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 08:03:50 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e8c2:f87d:c1c9:c637]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e8c2:f87d:c1c9:c637%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:03:50 +0000
Message-ID: <b60f9661-0177-5e6a-a4d7-d91dc35b9ab7@kontron.de>
Date:   Mon, 22 Aug 2022 10:03:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/8] arm64: dts: imx8mm-kontron: Improvements and OSM
 board support
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20220822080103.24016-1-frieder@fris.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20220822080103.24016-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0184.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3670d584-5aa5-4c27-d0dd-08da8414d91f
X-MS-TrafficTypeDiagnostic: AS8PR10MB4645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wl2TJdDP9zWL8gqrszeeSYVX6LhZ0ccMMY/aR/C9O+KxMo6S+RafErt0+phUYIl36xZFvl++iqRYgZ7hxBs6RaKuGbvHnoDVrVyeut5T8wJl2BdoDWtKJK9hgdrSsGm+vilz1j7WAfXnC0hexhCrVoFoK6bAdVUhq2JQW9U620gBo9pmZulnLdmdJeDiypu+izxO3ABqEEOg0qFMDlzyk1hm0kz8tNDGEpwsOxiQfj78KVum2zSXT52jMH9AidoxsovCpMl79DS+ZMv+TKrYCq32p/VgKPhRYhQj0U4DK0qtUQf7C9HgQ+OPbUI0RtCaL3kMEl5ottm4Kf2wTnhCNPGmuN6aqwfcKYcSxbaXzqOPn2mpDhdozRY6HNcnnxWfdEzQ1zXUpZwulzb2Pt83nTwdQut++uz8iiDJc6cTpaICaPAku/u/9pqYXAQHhPQn4CdXqP+O9eL8Vfc6+maLE8DIriDqAh5MDvZDtcmdCQwEvnBHgm6oesMfZVvCplpb6MQDu+cuGU8Cy7oPfxtDj1Tmm57VUDhVN7/0nix7ww/kS5ammPgXdoz9VJy8jWk00YfM27Msy1Vj94I5ZzLfnGY5MAy6ZM6Aaguwc3so7WDxs2snHzGEj8NgL+10tNqUAyQBqJiAudRu/43Itt5zaLnvYzNgHk5ioskzm33uG7n3euruuWbLMxzEH1QSpIcaPcZ4rlhfT6/btQAKHxzDiAxIABk3L4KNP++0D/xxxhT8F02lohQfAlOZ8uXbYcBz3CgKoNhwlpPnltbghopz27tYhAIW1Ni666VQJcPzjfnTMH3e4ZeLj4ZYNfhuNLnOAAtH9drezwI/+UcuQVGAtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(38100700002)(2616005)(66556008)(110136005)(66476007)(36756003)(54906003)(31686004)(316002)(4326008)(66946007)(8676002)(6512007)(26005)(6486002)(86362001)(31696002)(6506007)(5660300002)(2906002)(186003)(41300700001)(44832011)(7416002)(478600001)(4744005)(8936002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnE0SzNZSmZzRyt6N3JXQWg1VWNhaEJUZWwxZFAzVnF2NlhOZDBKc3NYRjN4?=
 =?utf-8?B?ZFRYSGdnZFE3b3EwVTlnbHFtMHp4Q1I2LzJUOGhxZHZ0SmQ3aVhRT0xOWlpV?=
 =?utf-8?B?cUxBMEFJY1FJd1h6NXBad0lieFNmdUVxbzlWbVY1SFRRcHN6ZU1TY1Njdi9v?=
 =?utf-8?B?Y3lVWVZIdGlpSzhqZkpWMzIxc3NQYmtNYllPakIvaGpXNFh2bHduK2Z4cVNP?=
 =?utf-8?B?Y3pRUGIxRzVXYXFaL09HeGVNaXdhVi9IOXlGb0JDU3NBeVRkd0dPRlhYalRo?=
 =?utf-8?B?QzU0QTZBOHlocTc2YlBEOHlsdlFHb29aQ0RvV3ZKVmRqZ3hkSWFubFMyWXhw?=
 =?utf-8?B?WUF4YUdENmlvVW4zVklyWlp6aXdPaEY4Yjdhd0ZDdTJNdWw3MDVDNVlHRmJ2?=
 =?utf-8?B?UGhTVHVEQ1FaMVlTaVJzMmNCU0VPekxkc1lNNjl3eW1CdGprRFVXTDhUUWZT?=
 =?utf-8?B?a3l6NW1YSFJpa1k5Z2xNUVdVbXVWNjZNbGxCTExoSVY0WWQ3T25qOXJTZ3JC?=
 =?utf-8?B?VVAyRnlPZkl5WVUvRVJsYktUTlpzV25xS1M3SjNqNHA3TUd2OHlFYmdETFhl?=
 =?utf-8?B?eDk3RHBib0RYaUpHOVNLdTQ2THFoUW45WGlCYUVNOTlsa2d6d0xrNi9wejVk?=
 =?utf-8?B?V2VOclR3bklLZHJRZUVMUzJLWFRVRW9UL3c5YkQrT0lXbWVSbXZJY1ZpcG1l?=
 =?utf-8?B?alJObFJ0ZFo5NHJhUUc2ZnVWbXl0VHNEZHdRcUlIOGpWbS9hUWNCZnMxLzFI?=
 =?utf-8?B?NHI0dlFjdVI0L0xGNTFORVdSOWV2UjhjbjdsSmx3M1hVemE1dkpSMk9Jc3F1?=
 =?utf-8?B?ei9yaEVIYkN2UjNEeWN2clhHS3FWS2FXMUZHemlRUHBkU2RsODhFUlFHV1Fa?=
 =?utf-8?B?U1VrUU8zL3VoWmVwWUN3QUNrUVJVbmRrNkxITzZJOTJRUDBOdFhrajJEQ0pS?=
 =?utf-8?B?bTk1Szc3cWYzV3l5QWhVTW5BeG9URnlhVUdBelNEODBYOEZyQ0JHaEVsUDZv?=
 =?utf-8?B?TWdxQnU2TDRmS3Zqa0JrWEtZV2wzRTRxZUpLT1FwRTZnZEhpVDg2aWxsczEz?=
 =?utf-8?B?SC84c1FqYlZWbENNNGZ2WVUyRFFnM3BERys1MFR1TWtOOEhUQTk5ZERVOXZB?=
 =?utf-8?B?SnNDL0dQcG9JOWVRN1pzd3FDNVlUdlFjTjk2eklBQjBCbXhvTlpPRjdjM2cv?=
 =?utf-8?B?RkxUd2JzUnZYMzNWQnB4Q2dHSldXMmQ4Um41Y0Z1eDdQU1BhcXdaejRrNENK?=
 =?utf-8?B?QWQyUytwUXY3UUZkUkcvWExSWmVYTkN5cnhLNWFNSTNma01HVXZKc0NBSlVC?=
 =?utf-8?B?RTNvaWlCWmtHUm50WkVKMUlXVEM5SzUwRDNQYnhmRzRVMUxZZjFyQUliVUNO?=
 =?utf-8?B?NTVKSUtBdHZ1WUdHRGFhanV4RlBwQjAyandTT2lmSHVWRXplUTZoSDVCdWd3?=
 =?utf-8?B?a1Ftb2ptTHpKTUwwVC9RVzJxTGx1bzhJKzc5Vy9VaGFkMnd1L3dQWWk2NzNh?=
 =?utf-8?B?MW9STHVjR21rcjM5a3pKbVAyRnZHQVFhSXljWWdtMkFrd09BSDJaeTBLNWFZ?=
 =?utf-8?B?Mm5NTC9ERm1SOHlacnNQeEtRN28wdFhVTUR2Y2M4cG4vK3UzRy9nS0p6OUNK?=
 =?utf-8?B?bUk1cU1ZU25Rb3RhR1FPSGYySW8wdUovcm9yYXpUVU1YMzBZNjgwTFNBamcx?=
 =?utf-8?B?a0dhYWg2VFFKSzBMK3hmcE4zVWk0YjdiSGlTS2o1cWFjSHF2UmpkREU0aG9W?=
 =?utf-8?B?N2dOM1pWTGNYZ2VpR3NpYXdPT2FUbURTYXhWWCtEbHJ5aTBpcldLT3pzaFFX?=
 =?utf-8?B?NWNtVThBK29RbS8xSU9sVVFudUZ0aW1NZ3hQRlRGK0FTVXZnOE9ERWl2YjlC?=
 =?utf-8?B?MllRalhQdTcwZXFuZ1ZqNHByMURxd3hYbWVYOWcyd0NZWEMrM2ZZdGtEZGdm?=
 =?utf-8?B?MFpQeEdiaUxMRzZwTWZ6T3RYd2k3S2tMazlMamVtUG1UdVZLb2ZhUjN0ZXJE?=
 =?utf-8?B?TVdHZTFpQllMKzZFUU95blM1a2YyZGtYbXRXR1YwVXhrcll2Z1lDODh0SWF4?=
 =?utf-8?B?eWhTT2NINFZXMTBBb290NzFEMlczUmtvZWs3OGU5SU9GRTIzZy9XQUFqM1Jy?=
 =?utf-8?B?OVJOdXVFTWlYNVJ4VksydEVXSGl5NDlPNEFWM3NmdFYrWFVsRW9TS3M5c29Y?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3670d584-5aa5-4c27-d0dd-08da8414d91f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:03:50.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXDYAqffnJp221RXJIGh3YBvXIwVTlDN/VXtUH7txPBaFCAMjn/vGLlQfGXXfig9N8NT1+3zsHLw8KexA3FOR42nPU+VL04haW4SotG775U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4645
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.08.22 um 10:00 schrieb Frieder Schrempf:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This set contains a few improvements for the imx8mm-kontron devicetrees
> (patch 3-7) and support for a new SoM (patch 8, including baseboard) that
> complies to the Open Standard Module (OSM) 1.0 hardware specification, size S
> (https://sget.org/standards/osm).
> 
> It also includes binding changes in patch 1 and 2.
> 
> Changes in v3:
> * drop patch for 2 which was applied separately
> * rebase on v6.0-rc1
> * rename compatibles and file names
> 
> Changes in v2:
> * move binding changes to beginning of patchset
> * Allow arbitrary regulator names in PCA9450 bindings
> * Use voltage rail names from schematic for PMIC regulator-names
> * Add SPI NOR partition layout to devicetree
> * Remove unneeded header include
> * Add tags

Please ignore this series. I accidentally resent v3 instead of sending
v4. Sorry for the noise!
