Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E6463BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbhK3Qem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:34:42 -0500
Received: from mail-vi1eur05on2125.outbound.protection.outlook.com ([40.107.21.125]:60033
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231442AbhK3Qek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:34:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHq1SxGpD5/isPp+z2UqSyIPG8d8mdHGMr+MygqduwbFvSux6R87/c5tMS5s75AlJN3/N1RssXSKVDF5neNTcIOd1CZ0POpbNQys0OnPNcBlL1GJIMjObJfv3sk5bRm2hgHT97V4igS6pQhPgYquT0Sep6LH32X7p4m1YQnZu9S9Ogylx/jdecq9i6Njd05p5rOSDea2ohjjDXN4qLMlWyFbT8tQYIIkCGZ2nOngwOGa63Pdi3uv314ppf/TaBo9M08itCld6buLZNVApsI/WInUmXHtB7QEAJeJV1LsFNwYFiPTWnVs5J8uJgj3onEmaGZ9OR1nHW5YXKMSfJzS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PegZci59j5HhJDFJIzFuUnZjgoZ//pGaIQ7Iuk1SG9s=;
 b=cnKhBJuS2ss+gVhfeKZIrGMmNXx7WGmkUKwlkD2bpSlho/eYf0wGNgPixKhCEda7fP6K4HqnhX4jlTcMpdw3mAtys2seKjWV8mdyD7bKt1e9MCvBMMWhL1fxQT5BvSnyoeVApMevhqn1tkie1LRZ4zbAg/34Bqt18oaU4zTKQzqfM+xp7VXM3oKMmf33HIBOqo6sAsECtvMbevspIx9mZfWyqoejo3KQ82ntHsKDH9zdWEnKs/qgqTGYfR/f9AX/gXlhQNW0edIIYK/+7XnUllNelGf1QhPHJOcSvvHvB0N5GhwcZ7TNa2WVeaeIqclmYvF7w7O19NhTvLSinJEcug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PegZci59j5HhJDFJIzFuUnZjgoZ//pGaIQ7Iuk1SG9s=;
 b=AhB2nchYLwcfEf37CHgIjYruHkSYr5T7T8N4FJ+Vfai/DSomEeFZ8ZMh7q1Zalg5f9n5c0RG2H0hf1GpWYTJQCoU4VZhFsrMOeyQQXL4OLMEHygcKsxjMyUoQg90EKxDUEedz6aXsakn0hVLmktjcgqOX74WzfAmYNnJL7G6aQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6421.eurprd02.prod.outlook.com (2603:10a6:10:195::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 16:31:18 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 16:31:18 +0000
Message-ID: <ce308034-b988-877d-8908-51ab4120c26e@axentia.se>
Date:   Tue, 30 Nov 2021 17:31:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] dt-bindings: mux: Document mux-states property
Content-Language: sv-SE
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211130121847.11112-1-a-govindraju@ti.com>
 <20211130121847.11112-2-a-govindraju@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211130121847.11112-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0278.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by AS9PR06CA0278.eurprd06.prod.outlook.com (2603:10a6:20b:45a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 16:31:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 629ddcd8-28b0-4890-6da9-08d9b41ed60a
X-MS-TrafficTypeDiagnostic: DBAPR02MB6421:
X-Microsoft-Antispam-PRVS: <DBAPR02MB64214A500727250E3E977F65BC679@DBAPR02MB6421.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4L3kXVMKhp7WRzBSjIkx2YlG9sf5jdwINpg+uqT1xSnmolMiJ9MZhcOc8RsxbO09YIw5CpEAwl0PeyS9xrX46CxV9NKVLs3+h/GwTBpVgqfacf3/zikfP4AUyxJddFlS6BMIlD5iJoMlBrhC82B1n1HnQq8YBXyu5KPkBSubv9hjizZjq2s71aWntKy2b0+me8wxpEkNmc9JXpXGv/AaCC84DzGgurpkRelS8SGY/m7ZGKrqcFLoVo9b1x+5k8qd5KWj0sF63oEbVsZ+8TukBN0zSGQjRr+b1L76dTCNEVvOwOZAiETNfDuaPfwbCkdoJ4tBsX5aUnpWfkM95de1jzYLL6+XsZMFz3NkygOUeFtjqWRjOpXrTmMll0Xgjiv1c9/XoNVS4in42qe+Uw+An4qmwmkO8GCnZBij27nz31r8daV4wmb06JnGIlFQoAJRfh/UsXyRoVW3WFQ8Ky7a6PZ3yjmWjb0X4nLJkxlE3WqsBxJz+i4Myu3AknbYbz0a9gLW79ufU/zQ8OvUEULQrf4prSp1+VxuptMRpIYkDYcB8EIPEeIjUqax3Y59f5ctMKjOsRFC6w2kPjAjou5puTJsPevWvlh3pww/HJo+iuyLLtQ58eoCvvpPGyBptGZUP/JbJOdAFlY8I+uRCasdqOU2ZHifXJppqQSrAUmf0okZLw9QrogpxTS8c6E2zJBBkZc0f1mpS3V5N1W3IoS0DeUToVK1vfEvsEpOCeA0a04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39840400004)(8676002)(26005)(86362001)(83380400001)(53546011)(186003)(31696002)(5660300002)(2616005)(8936002)(66946007)(38100700002)(36916002)(66476007)(66556008)(316002)(54906003)(16576012)(31686004)(4001150100001)(2906002)(36756003)(6666004)(6486002)(508600001)(956004)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFIzMjdrVFpsa2Q0NGkvU3RUN3JEMlVyZ1FjTnhLa1doN1NNYlRJL0ZKRGFI?=
 =?utf-8?B?VkR1R1krVUpUeE1jbjE4Y3Y3WVBBTWVLOHVuY0xTQXd2ZEVvQ2RYWlhNMkVi?=
 =?utf-8?B?SHcrdEs4WWlPd1RvZHBBd0t5Ym5kU3UvL2VEY05hVFIwNEcwNUVxRitnUkow?=
 =?utf-8?B?YWxGSkZhOFVlQ0tLL2ZZQVVDU0RkWHFKWFJxWHV1Y21GQnlHRjBSR2RsWDVw?=
 =?utf-8?B?UHVha2tWYXlJemQ3T1FGamVCVjNPZ2NId3h4bk8yUWFoOS9YTitXSU9ZR2FH?=
 =?utf-8?B?YTU5YTIwRXNmRmptUkF2TnNYVnYwUVdaZ3ZUeHZpSE56U1F1WWJhL0llTTlD?=
 =?utf-8?B?OWM3RVlqd3RPdTVOMU9RaUd2aE5ZK3crYm13QS9vMmFnTVQrVExndlhXcmE4?=
 =?utf-8?B?TDRHdDZ3SlZxb0pNRURFaW1pdmV1RjRxQkNJUUVEd1RlRjN0MjFSdjN2T3B0?=
 =?utf-8?B?UmxQMXFtVUxzTk91LzV2U1JHRUlnb2IwMmNQOUczRWJFODg0MEx4bGRWVVM5?=
 =?utf-8?B?bVlVbkYxZXpXZ3ZlUWhvdkhnWU9CblNMYVg5ckN3V3JRb08zajdKTDZ0WU1N?=
 =?utf-8?B?MTdRbWt0dEJ2NHZUWUxlTzVEYU9MMW9jUW5obWhCTHB5N29NK1hxcStKZlMv?=
 =?utf-8?B?OW5CZEN6MkdFa0dNbzZZYTFzV2RXRFJ0MVFkV1Q4VEZmMmxJV2tha0xHTUZM?=
 =?utf-8?B?Z1lxbjV1ck1Td2g2aXlabWxHZE9NYnJtd1VXNzAzM3ppdzU2SnpHRjFoR0Jn?=
 =?utf-8?B?OUtyQW43b0VOTlNwTEJvSktDeUJJUjQ4TXpRSGppUk9jb3V5cjZ6TXMrSEZ4?=
 =?utf-8?B?Ukc3cUFERDhNSjNKL3N3L29XaXVHa3Ercks2VEc5WW9zcFVIQU9zU0J6WEVI?=
 =?utf-8?B?czZuU1ZraGNMSEUrcE1ybmsvNklpWnU4TnJlL2p0OXFTMkJIU0tndDZBdXJ6?=
 =?utf-8?B?Q2lOaTFqMkxKNTluSE84TXpyUlhVekUwQkxMb2c3STdRN2oxeTNiTURqZE5p?=
 =?utf-8?B?KzFWMTJQS3hncU5ac0tiajlzVVdHbWxlejc3dDVnbWNmY1lVYnFRVExjVnBU?=
 =?utf-8?B?TGxaRWRyY1gwZTVDTHYvSFdjRHJ5TlR4MUw2SlIvMkFQaFJucnN6bGNIMWdR?=
 =?utf-8?B?cXlSZmNTK25zcXgrVjAwZE55dTlQZmtlbTBEcE4veWxNdVdocmtTSTJVY2Zw?=
 =?utf-8?B?VWlhTHNPcWRzcUJxUkcxbXM3YmVNZFo4cTBRTE9Kc21SU2V5K3NuUVN3bFU4?=
 =?utf-8?B?K0g3RmdGOEVUdUpXcDBOSnJxMU9vQWZnRys0YkxzdE5JNFo3WWVuWUYxN0pv?=
 =?utf-8?B?MnNETlQ2WkVuYlJ3N1AyUDM4R21jd2E5SlpjWWo4enZtNkdxUzNVbXF3UkdV?=
 =?utf-8?B?dzFKdUdKeWV1aW45elR4MjRaOXJISnVYM09UR0hLbWp5T0FlN09aTTMwdHdZ?=
 =?utf-8?B?TzljbVVuWFZkOWdtVWVDOHJ0K2hOeW9QSkt2NFdHL2dlbTNJdTRUTVYzY0kr?=
 =?utf-8?B?NXFYdXA1ZXdoWERYV1VvTWFYNEhHUGdDQVJ0bWQ5QzRBdWkwbVFObk1EUWxG?=
 =?utf-8?B?VmF4NWg3dy9qcFJuMVE0TEZwa3pyUmw3dnpnNWIzOXVQZmpCVVpuRGt1eU5Z?=
 =?utf-8?B?b1ROZ29SOGVqOThLbTN3WGZZdGp0bVduL0tCcW1JcEtiQm5KbFFYVjc4OEVs?=
 =?utf-8?B?RWF0ZTlGalo2NHA3YXFYdHJ4R2hrdXU4c2sxU0ZtOWlndkpTdmw4V2NxaDlN?=
 =?utf-8?B?RitCZ2VtWkl3K0swRGlYaFJMTnExZWZzZStPbC9jMHFrMWZiWVZYVHRjL2Ny?=
 =?utf-8?B?WEF6M01LYzVoa0RNbHZyblkzdmZib2JRZ3ZTMnV5djlQNWFENm5HdDV4YWdl?=
 =?utf-8?B?ZTk0dk1nV1hGZER3K29XVmZ3a2F1eG9ZSkV0eDQzNy9vV0pYS0dOd1ZjN3Vo?=
 =?utf-8?B?TmhYcmQ4MGJPUDArQXlKZktNeThIWnhicU9yUjVodXJ3TVAzV0t5algvZzB2?=
 =?utf-8?B?QVZ4bjRhWXN1aXBFYkNrcE42YWtQSkhvTjUzZHFZR3BIME5ya1IvM1JQZ1F6?=
 =?utf-8?B?Vmt2TURlZjNkcjlINTNpOGs2MktYV280emV2U3VrOHQ4d2RHT1oxbXJ4VVoy?=
 =?utf-8?Q?K3L0=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 629ddcd8-28b0-4890-6da9-08d9b41ed60a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 16:31:18.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqaPPQWTlyZOFWopKczitye42DjpDY6q8+0sbALxWuBrp+/Q+9fQ681QwRJPMx4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6421
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath!

Some language nits. But other than that it looks good to me!

On 2021-11-30 13:18, Aswath Govindraju wrote:
> In some cases, it is required to provide the state to which the mux
> controller has be set to, from the consumer device tree node. Document the
s/has be/has to be/

> property mux-states that can be used for adding this support.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../devicetree/bindings/mux/gpio-mux.yaml     | 11 ++++++--
>  .../devicetree/bindings/mux/mux-consumer.yaml | 14 ++++++++++
>  .../bindings/mux/mux-controller.yaml          | 26 ++++++++++++++++++-
>  3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> index 0a7c8d64981a..ee4de9fbaf4d 100644
> --- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> +++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
> @@ -26,7 +26,10 @@ properties:
>        List of gpios used to control the multiplexer, least significant bit first.
>  
>    '#mux-control-cells':
> -    const: 0
> +    enum: [ 0, 1 ]
> +
> +  '#mux-state-cells':
> +    enum: [ 1, 2 ]
>  
>    idle-state:
>      default: -1
> @@ -34,7 +37,11 @@ properties:
>  required:
>    - compatible
>    - mux-gpios
> -  - "#mux-control-cells"
> +anyOf:
> +  - required:
> +      - "#mux-control-cells"
> +  - required:
> +      - "#mux-state-cells"
>  
>  additionalProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/mux/mux-consumer.yaml b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> index 7af93298ab5c..64f353714227 100644
> --- a/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> +++ b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> @@ -25,6 +25,11 @@ description: |
>    strings to label each of the mux controllers listed in the "mux-controls"
>    property.
>  
> +  If it is required to provide the state that the mux controller needs to
> +  be set to, the property "mux-states" must be used. An optional property
> +  "mux-state-names" can be used to provide a list of strings, to label
> +  each of the mux controllers listed in the "mux-states" property.

s/mux controllers/multiplexer states/

> +
>    mux-ctrl-specifier typically encodes the chip-relative mux controller number.
>    If the mux controller chip only provides a single mux controller, the
>    mux-ctrl-specifier can typically be left out.
> @@ -35,12 +40,21 @@ properties:
>    mux-controls:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>  
> +  mux-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
>    mux-control-names:
>      description:
>        Devices that use more than a single mux controller can use the
>        "mux-control-names" property to map the name of the requested mux
>        controller to an index into the list given by the "mux-controls" property.
>  
> +  mux-state-names:
> +    description:
> +      Devices that use more than a single mux controller can use the

s/mux controller/multiplexer state/

> +      "mux-state-names" property to map the name of the requested mux
> +      controller to an index into the list given by the "mux-states" property.

And again, over the line break.

> +
>  additionalProperties: true
>  
>  ...
> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
> index 736a84c3b6a5..b29dbf521f01 100644
> --- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
> +++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
> @@ -25,7 +25,9 @@ description: |
>    --------------------
>  
>    Mux controller nodes must specify the number of cells used for the
> -  specifier using the '#mux-control-cells' property.
> +  specifier using the '#mux-control-cells' or 'mux-state-cells'

'#mux-state-cells' (missing #)

> +  property. Value of '#mux-state-cells' will always be one greater then

s/Value/The value/
s/then/than/

Cheers,
Peter

> +  the value of '#mux-control-cells'.
>  
>    Optionally, mux controller nodes can also specify the state the mux should
>    have when it is idle. The idle-state property is used for this. If the
> @@ -67,6 +69,8 @@ select:
>            pattern: '^mux-controller'
>      - required:
>          - '#mux-control-cells'
> +    - required:
> +        - '#mux-state-cells'
>  
>  properties:
>    $nodename:
> @@ -75,6 +79,9 @@ properties:
>    '#mux-control-cells':
>      enum: [ 0, 1 ]
>  
> +  '#mux-state-cells':
> +    enum: [ 1, 2 ]
> +
>    idle-state:
>      $ref: /schemas/types.yaml#/definitions/int32
>      minimum: -2
> @@ -179,4 +186,21 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mux1: mux-controller {
> +        compatible = "gpio-mux";
> +        #mux-state-cells = <1>;
> +        mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +    transceiver4: can-phy4 {
> +        compatible = "ti,tcan1042";
> +        #phy-cells = <0>;
> +        max-bitrate = <5000000>;
> +        standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
> +        mux-states = <&mux1 1>;
> +    };
>  ...
> 
