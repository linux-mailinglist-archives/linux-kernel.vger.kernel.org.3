Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C809D573D89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiGMUEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiGMUEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:04:08 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4CDFF8;
        Wed, 13 Jul 2022 13:04:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E16A2DC;
        Wed, 13 Jul 2022 20:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8E16A2DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657742646; bh=EyGDr5V/Nt8GJzbAAi/OLJlDIoto10JJfP1ptrCCEb0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SBXTXtodqKS/SXrIKFhsjgX5P+Z+yiCLMy0/ZSVkZ2kwNpBiFfDsfx5U2Do8Vn2b1
         NJT9UBNqud+wJXJ+PXpEtjIu7r4FHEOnsFFYtKcki70/w+VZQOHgMpjINZk8QY8LCK
         mYXRkovFcJbb7zKspqKvfsAPlP46T8bc41aR5RGtUtV4nIuuHqEHUBDCsG0/MtwqsV
         F1hdvofVVp+2uz5PjkKPOo4IJTO7dMHvyqaSvLGaYUJangkL2XuQyZpEskXbwmcKnp
         UCd2ror2nf70zV8E/KJAn7VQM2CXF7EdDRorNmAVJpHuPDMh7CphgYPtB0CIas8uqO
         bET8zcUo5q9yg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>, siyanteng@loongson.cn
Cc:     alexs@kernel.org, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: Re: [PATCH] Documentation/translations/zh_CN/mm/page_owner.rst:
 adjust some words
In-Reply-To: <20220708172351.20928-1-caoyixuan2019@email.szu.edu.cn>
References: <20220708172351.20928-1-caoyixuan2019@email.szu.edu.cn>
Date:   Wed, 13 Jul 2022 14:04:05 -0600
Message-ID: <877d4g4w5m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWl4dWFuIENhbyA8Y2FveWl4dWFuMjAxOUBlbWFpbC5zenUuZWR1LmNuPiB3cml0ZXM6DQoNCj4g
SSBub3RpY2VkIHRoYXQgdGhlcmUgYXJlIHNvbWUgQ2hpbmVzZSB3b3JkcyB0aGF0IGNhbiBiZSBt
b3JlIGFjY3VyYXRlLg0KPiBTbyBJIGZpeCB0aGVtIGFzIGZvbGxvd3MuDQo+DQo+IOmmluWFiO+8
jOiLseaWh+WOn+aWh+S4reeahCJyZWxlYXNlIiDlnKjov5nkuKror63looPkuIsNCj4g5piv54mp
55CG6aG16Z2i4oCc6YeK5pS+4oCd55qE5oSP5oCd77yM6ICM5LiN5piv4oCc5Y+R5biD4oCd44CC
DQo+IOWFtuasoe+8jOagh+WHhuihqOeahOesrOS4gOWIl+WSjOesrOS6jOWIl++8jA0KPiDooajo
vr7nmoTmmK/igJzplb/nn63plK7igJ3nmoTmhI/mgJ3vvIznrKzkuIDliJfmmK/igJznn63plK7i
gJ3vvIwNCj4g6ICM56ys5LqM5YiX5piv4oCc6ZW/6ZSu4oCd44CC6L+Z5qC357+76K+R5oiW5Lya
5pu05riF5pmw5LiA5Lqb44CCDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlpeHVhbiBDYW8gPGNhb3lp
eHVhbjIwMTlAZW1haWwuc3p1LmVkdS5jbj4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9tbS9wYWdlX293bmVyLnJzdCB8IDggKysrKy0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCkFwcGxpZWQsIHRoYW5r
cy4NCg0Kam9uDQo=
