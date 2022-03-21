Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F44E23F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346195AbiCUKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiCUKIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:08:20 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 03:06:53 PDT
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3715641D;
        Mon, 21 Mar 2022 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1647857213;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lIYdkrDN+PoNgoEibvd3dukVof0EVRd2O3ljM3bCXp4=;
  b=e0sOlllqTtuHd7mcZGZ+Fd7KRtY1lYqzpHEz9/A+kieojyi8FHBfBQR7
   QyXuAkhcZLNFueD+ziNZHpWvIJuZg2Lz6N5JCfvSeyF+bKtImynJ2aJVX
   RjaIyVuvacP1AZabDQ0bLh49b2LrgMARsz9hclIg2dmNtDtgF8II3vQas
   w=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
X-SBRS: 5.1
X-MesageID: 66664893
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:PaecO62bypCOpHoB6/bD5URxkn2cJEfYwER7XKvMYLTBsI5bpzwHn
 2QXXWmDaPbZazb2Ktt/boi39EwF6JbWytNiHlNspC1hF35El5HIVI+TRqvS04J+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILes1htZGEk1EE/NtTo5w7Rj2tUy2IDga++wk
 YiaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDfjZw0/DaptVBoaHq
 9Prl9lVyI97EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPg/W+5PwZG8O4whlkeydx
 /1rjLOeb1gTNZfH2/4SDgBeOTggPINJreqvzXiX6aR/zmXDenrohf5vEFs3LcsT/eMf7WNmr
 KJCbmpXN1ba2rzwkOnTpupE36zPKOHxO4wSoDd4xCzxBvc6W5HTBa7N4Le02R9u2J4QQaaPP
 KL1bxIoKzT5TkNjO2sFK5J9raSYmn/OMBRh/Qf9Sa0fvDGIkV0ZPKLWGMHOZtWASMFRn0CZj
 mHL5WL0BlcdLtP34TiK6HW3ncfUgDj2HokVEdWQ8v9snU3WxWEJDhASfUW0rOP/iUOkXd9bb
 UsO9UIGpLg480GDTdTnWRC85nKH1jYYWtxNA6gw7AaGyYLK7AuDQGsJVDhMbJohrsBebTAt0
 FCNnpX7BTVpv5WSU3uW8rrSpjS3UQAfKnUDfmkDVhcf5Mf4o5AbiQjGRdJuVqWyi7XdCTz2h
 jyHsiU6r7ESltIQkbW2+0jdhDChrYSPSRQ6jjg7RUr8sFk/PtT8IdX1tx6Ltp6sMbp1UHGnh
 VcqvZek59oFTouCyTWLavxTHZ+msqPt3CLnvXZjGJwo9jKI8nGlfJxN7DwWGHqFIvroaheyP
 haN5Fo5CIt7eSLzMPQpO97Z59ECl/CIKDjzahzDgjOiiLBVfRTPwixhbFX4M4vFwBl1yvFX1
 Xt2nK+R4Zcm5UZPkWHeqwQ1i+ZDKsUCKYT7H8yT8vhf+eDCDEN5sJ9cWLd0Usg37bmfvCLe+
 MtFOs2Bxn13CbOiPXmOqddKfQlRfBDX4KwaTOQNK4a+zvdOQjl9W5c9P5t/E2Cao0ilvriRp
 SzsMqOp4FH+mWfGOW23hoNLM9vSsWJEhStjZ0QEZA/ws1B6ONrHxPpPJvMfIOh8nMQ+nKEcc
 hXwU5jZahi5Ym+coGp1gFiUhNEKSSlHcirVZnv7OmdjJ8A8L+ELk/e9FjbSGOA1JnPfneM1o
 qG61xOdRpwGRg94C93RZu7pxFS01UXxUsorBSMk/vE7lJ3QzbVX
IronPort-HdrOrdr: A9a23:UnSFcqtqOFEbpnnvje9oHsOV7skCkoMji2hC6mlwRA09TyXGra
 6TdaUguiMc1gx8ZJhBo7C90KnpewK7yXdQ2/htAV7EZnibhILIFvAZ0WKG+Vzd8kLFh4tgPM
 tbAsxD4ZjLfCdHZKXBkXmF+rQbsaG6GcmT7I+0pRodLnAJV0gj1XYDNu/yKDwGeOAsP+tBKH
 Pz3Lshm9L2Ek5nEPhTS0N1FNTrlpnurtbLcBQGDxko5E2nii6p0qfzF1y90g0FWz1C7L8++S
 yd+jaJq5mLgrWe8FvxxmXT55NZlJ/IzcZCPtWFjowwJi/3ggilSYx9U/mpvSwzosuo9FE2+e
 O86SsIDoBW0Tf8b2u1qRzi103J1ysv0WbrzRuijX7qsaXCNUQHIvsEobgcXgrS6kImst05+r
 lMxXilu51eCg6FtDjh5vDTPisa2HackD4Hq6o+nnZfWYwRZPt6tooE5n5YF58GAWbT9J0nKu
 9zF8vRjcwmPm9yV0qp/lWH/ebcHUjaRny9Mwo/U42uonRrdUlCvgolLJd1pAZEyHo/I6M0kN
 gsfJ4Y0I2mdfVmH56VNN1xMvdfNVa9NC4kEFjiaGgPR5t3c04klfbMkcEIDaeRCds18Kc=
X-IronPort-AV: E=Sophos;i="5.90,198,1643691600"; 
   d="scan'208";a="66664893"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V95fT5xbOcX055NK9aVsuACjKcwU1ykfnsJfgtzWz1xh36vRkmD9MMN9Di8imvhwTUSz66/KlrA+7w10COwzLy/WSZyD1H7KkeM7CnMVD1e/KyGfkOsVqSxOvBjzONAuyBqOGs7jMtGCdFIoLenRHyBBdbNv5CCt1suai5w4QH5TPx+PYkQkEockCTgTchPwQh97sKzsSenIVjAZO6PbSWWOJ+41h13C3evJUtdspHQznTGRONapbhh6nybkMW6U5Gw/yVurbY2L8CAcciMxXdVS6Nxog7wCnLZ7Uhxr9sJ+s6RI8PQS+RpUya974iKCplufFpp2UuZDfIa6T9K+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1dHHPlb1CLo6A4GiwERElpYODVOZKRQMD0jDBxG774=;
 b=Sz2/YOvdM/op/KpVTr4IAbA1ukEkd3dGm4PGWYSwt6IHXflDnG+vZDC0MhlVE7ev64ibBms1HJBHmyG43Srjv9zGRNUWPfFR9a9DUnZM06nKUh6SVvHepXLvjfswFOmK+7I3fmD6fKCDN2ISOPCd+WwhYAQj4wF+tfjduRVfTEhn60UN/WwlWBJe0dNUvH9Y+V6CvbklyRhkE1HataOWPmmrZviRvyDnbF504rzvjazt7cQzeFA6jhnpfH0Ry/5ritH/6OC/Ucxygv5hmekPa1zjcEWKwqR9Ofl0rPK5+pHghZwVBy+NP5KjiALPAiUNgs5/LuHXINyJyeq4rjdarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1dHHPlb1CLo6A4GiwERElpYODVOZKRQMD0jDBxG774=;
 b=sWxgzsGQ0FQaC+xYF5bisDf0GgrA5jvI4c3v+UBt2iYhqw/jM+IhX1cuLu79ZW/5tM5hs5pMUl9ySMmFPWvhO2+xFOgpAcng1yuQLTc7op2rfVVG866Ver9JHTqzgg6LuHM2i5PuDc1baf64VFH67yvWxP0CK29+RV+6nBlaPAg=
Date:   Mon, 21 Mar 2022 11:05:22 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] xen/blkfront: fix comment for need_copy
Message-ID: <YjhN4neEJMs04JEN@Air-de-Roger>
References: <20220317220930.5698-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317220930.5698-1-dongli.zhang@oracle.com>
X-ClientProxiedBy: LO2P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::24) To DS7PR03MB5608.namprd03.prod.outlook.com
 (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f66fc39-fdb0-4bf7-b9fa-08da0b225289
X-MS-TrafficTypeDiagnostic: DM5PR03MB3273:EE_
X-Microsoft-Antispam-PRVS: <DM5PR03MB327327426804C03549FF25F28F169@DM5PR03MB3273.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfmjY73vSKkW4a4P5htNVjFhAnilfxLCQk9t6qaNlEF5Ny/yznyOUyMagbh0I40kAB8V9kPYCAmzec1r8Hq2+rAXp94fK1DP2Vml/agYBLMraDRUJ6RhgTulWBJsV9iLZziuRsaudZzTkA7Wxk6qsijjKrrkpYGClEVwIJ5EzxAdtDqIVtWS0R0X4lYqnBUBdenT68g/+F7KDkuJy6UPpU5lgYqtYLJxN8FX8LyFEcjRW1Lddax3ugXXVeSjTYgHephGId1IojQP6YFOJqcymJiWyiSodoSqiMOKynrKbqH4F2qlGtDiBsnKQyIZZFnSFH8HuB1AdWBNT3zTZe6EHnEbb8aD+QaRyTZHQ3A/2BB4aFezytoHeU2ZfGYToJov4x2u9fED7RYz76bCCyySWOoyn82Lyu1EvFGextq0nP1Ix5A3+SL/jsZY8CpGrY/gnFHareGgLqKKP4hDjzHGJA1muoMwr2d9H2PxNdi1YObCtAnR1k2RK0p8Jsuj0WB3/xLdA/rAjhBjUUjSiwYnMTwC7Cd1ZK1mxgo0enSlsl2WOt7cY2zMT4Lv9EqIgIHWk8oVaa/x/fCzh++7/qoJyNjppBcvuOgfMto4FRctSpkVoIZR3j+CoZXJMsuNGsx2qe8tvXOk6bAw/IjBVgT+4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(85182001)(6506007)(8936002)(6512007)(9686003)(5660300002)(86362001)(33716001)(6666004)(83380400001)(4326008)(6486002)(26005)(186003)(66556008)(66946007)(38100700002)(82960400001)(316002)(66476007)(8676002)(6916009)(508600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZ2ek1PMDZ4NlpkVE8wYjZwNkljTGpVK1Zkb0VRLzk5VkZ6Nmc2d2FhWTdt?=
 =?utf-8?B?a3FYZkl1d0pUUlVwQ1l5SjJPS25ISHZUOWQ2L3l3d2NGZXJzUzQvYUs0SWR0?=
 =?utf-8?B?Z3B2NTZZOWgwOURTZEQ1TmpzamFsTnU1Z3hnSkFYTFJhOW1jNk9aVzl2d3Rk?=
 =?utf-8?B?VXpRWXpHSXcyZkJLNzhKaUlyNVFhRjV5bEJGRTExSkhTdWxoMTgrK2E4N3pX?=
 =?utf-8?B?ZDkwdlpDQ1paT2tyZnlKNVJEa2ZpdlBDcUx6TjhRWFpxTFdzMGZBZWxoNkhp?=
 =?utf-8?B?dEpmN0pvaEpvZHFZRHBKbDlhRVdCSUxSeC9JZ2U1UzhWTGFGZXY2dnJ2dU1j?=
 =?utf-8?B?MUNJM2RYRCszTnBiOG5JWWtJRnlxaE1pd0w0bXFXUEZZM282Q2hqdXhzcFhz?=
 =?utf-8?B?dlBpaWVBRkpCSkE5aHU2R1g3MTRXWGZnUTIyajJ4U1VqZTlReXFUVGFHWEtj?=
 =?utf-8?B?WTR2ZVJsWlB4QksvMnBocWgvV0RvNnduWnIvb0g0enRTOERxcWdKVTJNT2dR?=
 =?utf-8?B?OFJES3p5dStxUmtTUGpRTHdPOUVJTUM4RHlLbzlPRUZFT09FUjEzVWJMeThz?=
 =?utf-8?B?akJqYXcxcS8rYkRaNjJya0Z3MHZUcWt2ekxkK0U1VUZSNmM1amlnTmNmU1VM?=
 =?utf-8?B?TEZiNnFUd01TeEtzVWhZa3B2UU4rTm1qR1F6Vm5JNHZYSzJ3Mjg0Z1pZNjhZ?=
 =?utf-8?B?ejRwVXdMRWhYWnpxdDNYVFYxWGNBSHdSTERMMHVSQlBoSnVuNHRvRi8rSnU4?=
 =?utf-8?B?QzNMejB4U1hmaml6VlZKU3lHbWJ6bGhsc0pUaE1Lcmp6RS80aFZRZEE5SEpQ?=
 =?utf-8?B?dVcxN2NrQkhLcTYxYm8zRnVLeFNLc0tDVHdvZzdOMTlOYnRXTkxFbjJiUDA3?=
 =?utf-8?B?NkZxaTZpTjJqdjNUVys4VnBqaEFBTVlHUEVzMXZuQjFBc3dNSjVxSmdBYmRZ?=
 =?utf-8?B?S1VnWE5GZWw2ZVN3ZzRoSFNiMmJFc0gwekorRXpoRnZWOTRFYlVYbXQ3SEla?=
 =?utf-8?B?bUFqWUprZnUxL0ExbWgyWCtSd1JRQVlTZGN1UlZtRnBndEZBVTI1dlVYTWx2?=
 =?utf-8?B?ay9SckNuYmlCVkZ2RWNZMUlMK09GZUIvYk9lRHE1MFZwK3pHNXFGcHVaa3pK?=
 =?utf-8?B?WUhnRXlTSzllVTBrUitmdktwaXlJaUFPcFpuanBaUHRlcC9Wei96dklyTFpE?=
 =?utf-8?B?eWNDQ0VWbXY3ZFRZQTJ0QUJFdEFTTTA2RnFFMzFNWjhwU2hCWTIzcHUwU0gw?=
 =?utf-8?B?aHJZbHFOUW5HZDhJd0NTQmJDUmF4MERWWldvKzErZEdhWTJCYURWQmpEanM4?=
 =?utf-8?B?ZkE1YXN3aytVOVl1bnhJVTJDNWwwck11U09NYXYvOG51TWxEKzd2UWVhNkFY?=
 =?utf-8?B?UjJrZkl0eVlWcWtQWlhEZmdLM0w3OHRnTXNKUWF3UnpOa2ZmaURsMnJOa0xH?=
 =?utf-8?B?OUtZRllVNFNveHdKNERKQm5maDJveVV3enBXVDROVXBISVpDbmRDRWZ1ZXFq?=
 =?utf-8?B?N1ZhbDhlMFhZZ1VWK21aMTlQc2lXYWJ4Z2llcGh1TWxvSEVzMGtWdmdmck9n?=
 =?utf-8?B?VUFoVTFXaG4wK3NoZ1RhYzA1SUl4bUl5V1A5bmxjeEgraGpYSUZyZUp5NGtW?=
 =?utf-8?B?YmZVZEdFOVVLRUxKclZsZDUrRHM0eTJyOGdSZmZVMFB5bmU3QnRiOXJHN1Aw?=
 =?utf-8?B?Rk5iNXlGNTBPZXZZTkQ2OW5kdjc1MUdvVnVZb05yTTEvcko5NCt0aDVvTHQ4?=
 =?utf-8?B?Q0hOYnJpNVR2bkhtWUszWXRGc2VTVm4yZWNxUnB3d3lHR3VMbkZDUHJLYk83?=
 =?utf-8?B?QjF4eXhhVkkrTnlLamp4dFdUZVVUeFd0N1RwM0hSYUY0OU5PU2ZJOFhoYkVm?=
 =?utf-8?B?MSs4bUtsNVYrSUYwZ1dwemExVHpVVmNaSElqZEZKTjNzRDBscXBiblJGRFBE?=
 =?utf-8?B?K0FrUERiSmdRbWJGRVZGV2VrazcwaW4zYTlISUZZV1hCYkxrYlFubjRRMnJq?=
 =?utf-8?B?WFJ5TXlkUDNnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f66fc39-fdb0-4bf7-b9fa-08da0b225289
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 10:05:27.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dhx0RguqCNTaN3hF1ayFqj6zgLMhF8E1bcVS9eDZU4mV1M2QFK8jPFpF27DL7fQQfOhk1VluclUqUmiNcfe0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3273
X-OriginatorOrg: citrix.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:09:30PM -0700, Dongli Zhang wrote:
> The 'need_copy' is set when rq_data_dir(req) returns WRITE, in order to
> copy the written data to persistent page.
> 
> ".need_copy = rq_data_dir(req) && info->feature_persistent,"

I would also add:

Fixes: c004a6fe0c40 ('block/xen-blkfront: Make it running on 64KB page granularity')

> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Albeit I have one nit since you are already changing the line.

> ---
>  drivers/block/xen-blkfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 03b5fb341e58..dbc32d0a4b1a 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -576,7 +576,7 @@ struct setup_rw_req {
>  	struct blkif_request *ring_req;
>  	grant_ref_t gref_head;
>  	unsigned int id;
> -	/* Only used when persistent grant is used and it's a read request */
> +	/* Only used when persistent grant is used and it's a write request */

While there you might want to adjust the comment to:

"... persistent grants are used ..."

Thanks, Roger.
