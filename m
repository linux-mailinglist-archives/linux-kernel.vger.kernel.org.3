Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F656D8DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiGKIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiGKIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:51:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A10823153;
        Mon, 11 Jul 2022 01:51:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3137316bb69so41757687b3.10;
        Mon, 11 Jul 2022 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pHQn1JVWbDSH3JZfxKdnwJpphKglDSbLfd4kF7J211M=;
        b=qQJAowdJUsDa2J/lzEGAR/ykKnf3eA0zoA0/0qowgm67UYLYdXwxh8IFZJ1KMmj93U
         SzH5E1gqWdjqNMSwDvbk8NCp2upljSBSOCgoqqqzv8DBfNKgULsZQxDj7FCZ+6XXc/1z
         Jy386ma2+EmqkuPDrw1OIMbOcvyP7+seNvKnAmdtIwxiPY1BRdUWwoJ+pvwY8qGR0lP+
         Cj9tBFCC9eRojzNyz85rvdh6ZxRchzlOqznRq+5UCAKcdRLL8snYrsMvCGtnOuVn6LHs
         Ui883yKHSIpGAp/QXA/+RNzMUVspGIT14fOv5dh0inoV1CVR3RYhLZ/Jt0FYFqEqSg1X
         WiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pHQn1JVWbDSH3JZfxKdnwJpphKglDSbLfd4kF7J211M=;
        b=YZD8+xn3MacsYZGa4bs4ABAms8XHCQKY/1lijAAjcvQnh9ypHNC4kUetFfPww8AWZH
         DGKeFfRNFKiG3g+n8OA8wJ7A+EHbCdR4N2DAGEMyPb+B968HEV6z4u3Xk3eAswDer9sm
         ciRhLfNzUeq1O2HP4P8vaEvbqN/ur+7ez9diK6bzHVpmDMym5z7sYyfF6ei/47eHHBmd
         /iBDnm6huthVGPSLVgb4AQ297LzQKsB7mwbuMM54SqA8V2iFsiUv69NToEVJjCOzVUq5
         5tgcpBzZKCqpEnCELHbsWH69N92kM/4H467kUzvxCMlu+GfRfWDznoWIeg5hCP4sPKau
         gQng==
X-Gm-Message-State: AJIora+DMn4hGMtd3y7XYoXl0nxpPZ1N45Yf5qErGNOFukEs97BeyNQI
        bcL4SKSNiO3Rf1JuySZkxglhN4OIKkp6Ne/Sb2E=
X-Google-Smtp-Source: AGRyM1uJ/p5FyiLt1lkFAzNbU5AnfYyf2RWk0tpW8iuxeoiFT3pt+a4iDnWPy6GED9umPbisV3/kx6H3szHL2bJ0xOo=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr17717422ywq.18.1657529466146; Mon, 11
 Jul 2022 01:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
In-Reply-To: <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 10:50:29 +0200
Message-ID: <CAHp75Vfnt0DX9wnx0pKhit4JWCjBST+4caTjY6x6VYNdGjqn9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev support
To:     PaddyKP_Yao@asus.com
Cc:     Hans de Goede <hdegoede@redhat.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        PaddyKP_Yao <ispaddy@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luke Jones <luke@ljones.dev>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMTEsIDIwMjIgYXQgNDo0NyBBTSA8UGFkZHlLUF9ZYW9AYXN1cy5jb20+IHdy
b3RlOg0KPg0KPiBGcm9tOiBQYWRkeUtQX1lhbyA8UGFkZHlLUF9ZYW9AYXN1cy5jb20+DQoNCkJl
c2lkZXMgd2UgZ290IHR3byBlbWFpbHMgYWdhaW4gb2YgdGhlIHNhbWUgdmVyc2lvbi4uLg0KDQo+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+IFRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB0byBp
dCBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgYXJlIGludGVuZGVkIHNvbGVs
eSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC5J
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9yIHJlY2VpdmUgaXQgYWNjaWRl
bnRhbGx5LCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgZS1tYWlsIGFu
ZCBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBmcm9tIHlvdXIgY29tcHV0
ZXIgc3lzdGVtLCBhbmQgZGVzdHJveSBhbGwgaGFyZCBjb3BpZXMuIElmIGFueSwgcGxlYXNlIGJl
IGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3JpemVkIGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3Ry
aWJ1dGlvbiBvciBhbnkgYWN0aW9uIHRha2VuIG9yIG9taXR0ZWQgaW4gcmVsaWFuY2Ugb24gdGhp
cywgaXMgaWxsZWdhbCBhbmQgcHJvaGliaXRlZC4gRnVydGhlcm1vcmUsIGFueSB2aWV3cyBvciBv
cGluaW9ucyBleHByZXNzZWQgYXJlIHNvbGVseSB0aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBkbyBu
b3QgcmVwcmVzZW50IHRob3NlIG9mIEFTVVNUZUsuIFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJh
dGlvbi4NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KLi4udGhpcyBpcyBwcm9ibGVtYXRpYyBhbmQg
Y2FuJ3QgYmUgdXNlZCBpbiBvcGVuIHNvdXJjZSBwcm9qZWN0cy4gQXNrDQp5b3VyIGxlZ2FsIHRl
YW0gaG93IHRvIGRlYWwgd2l0aCBpdC4NCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkFuZHkg
U2hldmNoZW5rbw0K
