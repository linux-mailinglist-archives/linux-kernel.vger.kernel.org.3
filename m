Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CEB51FB7F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiEILp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiEILpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:45:49 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30094.outbound.protection.outlook.com [40.107.3.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C31D4A30;
        Mon,  9 May 2022 04:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOJ2440NG+apfF22WdaoEEOuxD8XauZvo0Gt31l+cHAjziy874uTbD6TGGYhbRE6dZMwcgtvnzic5U652J1vEHuqdkSeAKHkl9cBcNsj+/+0+V3PzeuyGNd8lZzawwzAxXX/Gf0uu0ryzlBHj+caLNIsdA9FkeZWAugEri43ISlVbO5+Rlj7YB7bGYWR0kwNYD6sKyMcA/RFG9yv10ldQrxfzfVI5jHEw0kLS8MpyrO2Xfj/8rY6C0fda63x+O3IPzB3FG0toEki+hllXRyqTBWW4GyONgxK7yQbmJ89qgsk3tTZL5D1LXfagXofJfSHeU6HbwWcH0t4d7htvluzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/vFa8P14/yxXPRt9V9uUx/OZldwRCglBzmcEbmOoaQ=;
 b=GYgo1LjHTLj/0b4LBrZdKCwLLfwvz1S0FDz3kk3ZA3/VMTHos6SRxmnndghw950Xrxres1ySSHyQTP65LyeyBys6zGaUHxQAFHsY1lfotxSOIJncDcrVCzdJi3eyxjWM1vtBfbb9tIrTxuXP7nYI/9VRy1y0cCDHbB3S8sHh1uWhkBALviV/afVpscTmZUjxfn1tT+mteE0iCK9eWI4sJLSBxIzE+atCkQeCQlIYzyGmHe4TIPhPdX7OIIhn77wKsJcD8lPFSpxUgqOCFlqwmYzDx9EYM1Svn+Z/8/zvJuNlyOwIo23pVS4LZq/L0bSC7SjzeLDNYoqpgQun+ZAf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/vFa8P14/yxXPRt9V9uUx/OZldwRCglBzmcEbmOoaQ=;
 b=UC7ABItcWQ4tCk9TU8zPlo1q/ai+m+SX2DhY53hx/czyaiJULBHTBXcpyu+6cCQpvg/DA4Lo3ZrVwSgc53X+xk+kiYXpSvO4JWs+81w34ubOeAjPeyGQ/hlANQXlKpQ+2fITPJWLvqLM+0s5WJqjfO4Gvo0cT3+BEz/NdvMDq3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS1PR02MB7919.eurprd02.prod.outlook.com (2603:10a6:20b:4a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 11:41:52 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.028; Mon, 9 May 2022
 11:41:52 +0000
Message-ID: <f8c2895c-d8ab-fd8a-7327-8bb8699df1a9@axentia.se>
Date:   Mon, 9 May 2022 13:41:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux
 controller
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
 <20220509084920.14529-5-kavyasree.kotagiri@microchip.com>
 <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
In-Reply-To: <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::32) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00b4c2d2-d926-4078-3dd5-08da31b0e909
X-MS-TrafficTypeDiagnostic: AS1PR02MB7919:EE_
X-Microsoft-Antispam-PRVS: <AS1PR02MB791963ED7B89A41FD6C1546FBCC69@AS1PR02MB7919.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: db6OGLX9MuWrXzadCpijqUW2QrdbBlTmTa0jj4dvcrHiUeC2GyS5oig65d2q0/mLaEUy53q+SHASDQInRnOMm9GtcU8SOpgJe8NrsVkTqOFH5uEUjEYzNzHBoXqxS0iHefKiTRmUbBjwNkp2MxKUPAV/ex6Yese/id6n6fI0Hq3kMEp0N7KGaVHk7/r3nSBjCXqzivRLZIXwI05Zy5I0WQW99zT61WXqD1pI2FMCnoBn69XvmzyUnHTYa/ZFEm+Rw1F6Rbwjft/o1qUhBRO8W0Ws5ARa4EmftpgPCqYDn1Tc91nodHjbcpcrjuemBSkIZAC66K3p83HVFb1u0/5UxDhRwwOR9e77lzdqDhLvsmjykCiFTtBMUIa955LOwZ4nPXyFvbgu1VUMKrd1lBMkM7Tb3QlCzmBuSAnLElRk3HbOzsQtZB6gyYqc6CZjGqADlNvQluZRvEDA2FfFPxe+ytQ0XfhiR2uuiU89980NtZ9F6AW30IAcFYbNUvn12uwYSDOTzwWKmy1cWFm/SfIVkYFToq7eHGWmsSmV/4lyKchwJ8MTQZ6MplgCl0mOfJyM87iGeole//lMAibP4vluKezGKxeBDaKAxMJhW3eofhCYDOuQZB+QYBcdpucpXrJyNj3H0R/sSeZZSZt8JPJou5qLnFY4yMPjcu0U5r3QzBtlL6hXmsqc/CdYdqWs4JPELzi0HwPehFGA1tra1wfzZgPAe1GoA2oudawZ43ChS7pJ7/XrsSADybj63lYx0TE7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(136003)(376002)(396003)(346002)(39830400003)(508600001)(558084003)(6512007)(6486002)(186003)(6666004)(6506007)(86362001)(2906002)(5660300002)(7416002)(36756003)(26005)(316002)(83380400001)(31696002)(2616005)(66556008)(66946007)(4326008)(8676002)(66476007)(38100700002)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlQwQm5PTGxpQWhSOUVhNU9lQnVESm53OTQ1dDR5bnJ1eUM0REZpamtnenFJ?=
 =?utf-8?B?L0hSR0tFWmJnUEluQU1pcUZReElKbnByaGZMMS92cFZjaVZlYmZLK3VGdEc0?=
 =?utf-8?B?R1JEYzZPYWNoSmhEYzkzVFJaRWNyUkI4TEFReXlHR090QTRrTzZhWGEzOU9B?=
 =?utf-8?B?aVJJT1VxQVlHeUd3WWttekNLTHpVdGE4NUdMY1FEZ1hIK1FVUWRmcnQwVVFD?=
 =?utf-8?B?YnA0WmhkVTZ4czVrY3dGV21ncVVlQnI5OVZjU3N2VWpRRURGUUdRZm5Bd0F2?=
 =?utf-8?B?SFJvTitkM2hGMnZaRkRCVXFyaW9xQ3dCajI5TmJ0RmZHNGg1VEpLSDdwVEts?=
 =?utf-8?B?cFk0V3JzbTJQOVVicUJYdDI3TnZpQUN1M01wZDhTUlVUZndFVTRFMWpjbm0x?=
 =?utf-8?B?V0VLMU52dG1PdndiSzVqWlFUU2RYVWVGVzArRis4UnB0TTM4WXFIbUk3YjQv?=
 =?utf-8?B?dGlZbnBTMWQ0NjNJOUtSbGNDQWlvOXBaNVV3bHhMM01kRGg0OWF2aUFRVk1Q?=
 =?utf-8?B?d2xUWng3YVBoTmJaN3BybTlVK1FIdEQrRjR1S0FSTFBJemYwd0E0UlBvb0hD?=
 =?utf-8?B?YzBHQUVndHhCa0JBdUlxZkxobFJWc3RjUmJDR0JIQVFoRmMwUDFpUEJyVDI1?=
 =?utf-8?B?Vlo2NkpFdmJaTzV3NjlnelBYemZUV254RlQvT0dDY1Jka05kUGdxelprcmhL?=
 =?utf-8?B?NmdHeElQUzZiK204QTkya3lVMGc2ZzVXZUlBeFlBTkxyWlA2a1crK2RPeXg5?=
 =?utf-8?B?dm5EODVlUXM4SGE0eDJkdXF5Snh5c1pUSUtoS0orbkpVdjhLWGxZWkZqSFRW?=
 =?utf-8?B?M1ZtaDd3VlF1S3ZHd0JZdmZwQ0VmdXVxM3E5S0xPMEJNVEkrTHNtV3BrM2RB?=
 =?utf-8?B?YkRBRGJIV1hJK1Z0WmN5WVIrL2ZIenRIdnk3eU9QYlB2YlMyRDUrMWkzYngr?=
 =?utf-8?B?WHQzQnArYXVTMUVwNVlMWkZscVIxNUhSbWFUYXBWVzlzbFdIZnhsbEQ5Q1Uv?=
 =?utf-8?B?dm9vbVRNWFhpQS9nSjRoNjUxelZFbTZTVkEvQmZwQ2hJK21nTW5MM1pRQ3dk?=
 =?utf-8?B?eENTUEx0cHFnaWF3bFIvY291cTQwTENzVXBLWGE0T2xpQkJ3YVYvNWJlOERn?=
 =?utf-8?B?NjhWbFhhVDJxUSsyMWFyTzJrakdnNFIyTk01VHRJalBCV1BLMEdFYUlpNHAy?=
 =?utf-8?B?VzZyNnVWbzY3cEVxYTE2elk3cktzaC9IaWsxNjFLOVZMbmtJTVdBQWNhdnMw?=
 =?utf-8?B?eTNlUTVlaHBzNmxEZktFckpIWGFCNTRWRlNsOWsvTlpYa3VkWmlFQUNCZHV5?=
 =?utf-8?B?S3Q5NlI1TllxVXlzaFphOXg3b1RxWFhmVDFsRXNmcFg5dWg3eXdSSmt3VWhB?=
 =?utf-8?B?Y0IrRkh6bm8wZGQvaDByNlM2dXNPTGN5eUZacDVySTJXYklxcndkeVVOZm80?=
 =?utf-8?B?NlZWWXRTSjhpRVFEQlMvbUx2Y0FqQjM3djR2RTQ5OEZjQS9pTjhuVWQzOS8v?=
 =?utf-8?B?V2RVZ0hULy8rR0p5Ni9OYXRCc25vUGRxMGNDdWJyeTE3U0ZOZkh0OCtySC90?=
 =?utf-8?B?eWU0NU9QMklDaWtVK1BkQzFCWlc4Vkh1eHVCVktlblpZT0pEdVZYYmpoSUhF?=
 =?utf-8?B?MU5kQmpoRVZNL0dsdUxYbG9LTWlURUo3QnBVR1o2bjhjb3dXcnV5WktKSUR3?=
 =?utf-8?B?MDBzZFpaSURCTGNxam0xZkZhRzFNTE85OUQ0RTkxeHdwOHU1cFkrQlFSdEli?=
 =?utf-8?B?ZEhxOC9QNXhVNG1FUmZZQWI3K2xqTzZ0OGEzQmJONDBva2pOeWtuaGw2R3ZS?=
 =?utf-8?B?VEtaWjBtUEZWRnlHV2xXN2pOYkx0YkYyVDhCRmhwRHZjSUNHR25DV0VFSm1C?=
 =?utf-8?B?NE1YZzBwYmhyOVcxUlJOdkMzU1hVYVRZNGFUUTBHb2R3NWowMjh4cXNReW90?=
 =?utf-8?B?TjVqQ01kQXJpUFB0emlaek9ucHpOd2NCS2lpeFZIM3Yyd1dRdHZCVlJybVNy?=
 =?utf-8?B?dVJHT1FOSmYzV2NWOWVySFRBZ0dOQ1M4Nm9QUDZzVjZHYjJRKzRjRDQvOGh6?=
 =?utf-8?B?YjI5RlBrOXJIMjZpS3UzVW5lckZPclR5bnU5eHN1SlRHby9sNkxqQXhGMEFi?=
 =?utf-8?B?amdvTEhRdlg1N3RwWjVQTEFrZUJsUFlOVk1oY3JXY2pBbURuTURmQTdtbU5T?=
 =?utf-8?B?OVJQTXVyRjRIQlhta0d6STB6VkZWVzVOcWViMk1MaEtTSlVwS2pzaHlxMk44?=
 =?utf-8?B?OGFHNTdZOXNzMExzWHVFZU04RllxTjZid3QzZHlqRFpsL1dMQkE5Ymdud0FD?=
 =?utf-8?B?THJubFBKdUhyb3F3TUtSV0VZdWcxMTdWem5oeXJpeWRmdlNMa1AvQT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b4c2d2-d926-4078-3dd5-08da31b0e909
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 11:41:52.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DB4n3aJDNtRLZKgxQhmb0Cz50G8eGkB+5/BsG83Gkn7bbWayCHspSrpPDZ3QiLLo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB7919
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This clobbers memory you have not allocated, if num_fields >= 1.

Oops, >= 2

Sorry for the noise.

Cheers,
Peter
