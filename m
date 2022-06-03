Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D053D2F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348214AbiFCUw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiFCUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 16:52:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733251D0FD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 13:52:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u26so13676979lfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=INm2lKIJIOK1vkfeeO9IkNQLYQIEPvdab0PRt+gAhcU=;
        b=ZGlF2wwfgSdRhb2kEUDAHV1jdX3qfvCmrfU7vIkJt3ArsZVnx4KkrSL6CVL92moobT
         8TOiuASeR2Heyj5VxakFWKRmP7mqjKxIeQyMWcF/Tsq+/j0WIMny4dhJ9ylwu3L7fXRL
         t4c5rgIVMVHHicGWtLaKTvGzWWpVpKNq7gdrr8BF+x6lXbmg7EUBDHSy3tytb7KQmzLN
         K5OZoQHOB3++0nKJUoYSFyTLLCVRKIYx4tHzSzuYVrxsaybGXKu3gv6T0GGYQ/y8dAXf
         cNXxCQwk7/ZGglnfee0PuTYHC02W0M5H5a2d7lj/shjBTxyjbVnvOSavXNW3pCe4REZP
         uukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=INm2lKIJIOK1vkfeeO9IkNQLYQIEPvdab0PRt+gAhcU=;
        b=FT9IzNfqTrMjrMEWh5s726mDDIB2EvWSdrBH+b89Q3RhgzhzpYe/yF7KVfGcAS8V4d
         tK2GxCVqgyE9as+/FXdUGDxbkSpyc/2BkkfLlgUO8K4xUjL2APPSD4ihT1sGcbb892Ts
         S9N9UHIgkjwO4JP3RxUq4rJWj37nINfuT+7S+OfCc2DKBrn9PP2Dw4hAebaAdpE7bph3
         D//C37y57rWKi/uKd9PA/OC7SQmNyOsdZTukjGQ++o/EafcpwxzwFHXZKnpNB70vULzl
         6RR9hqKwqotjqyfQbU3LLaWd7ILaEetlC+t7ZTFXOPEtz9X0Vtfftp5L32jLXuNvkFLu
         9ExQ==
X-Gm-Message-State: AOAM532Izbvu8ZRFBlQPf7MArQ5jwFMNxJLFkeLEnFo22ihziWDdE2/S
        bwIsLgYpt8LF7Skr46yssHXfrb4NgpI=
X-Google-Smtp-Source: ABdhPJxpwbxhm/c0M3AWjfq7icUalnd2xF6MGErptO9eYHmQ5Fm6Fjf0GO4aGJTwT+XszPRunM7+Rg==
X-Received: by 2002:a05:6512:529:b0:479:2158:da27 with SMTP id o9-20020a056512052900b004792158da27mr771824lfc.389.1654289544444;
        Fri, 03 Jun 2022 13:52:24 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.4])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8502000000b00253cd476074sm1448461lji.111.2022.06.03.13.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 13:52:23 -0700 (PDT)
Message-ID: <1fd1374a-132d-fc38-fc96-ed9c98e3ef8c@gmail.com>
Date:   Fri, 3 Jun 2022 23:52:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/3] staging: r8188eu: some minor cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220602194807.281115-1-martin@kaiser.cx>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220602194807.281115-1-martin@kaiser.cx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1xABE6dtyAJLjVB6UXL9h6Z9"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1xABE6dtyAJLjVB6UXL9h6Z9
Content-Type: multipart/mixed; boundary="------------6WFRi6R0nSoPDdhXDMj27Dzx";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Phillip Potter <phil@philpotter.co.uk>,
 Michael Straube <straube.linux@gmail.com>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <1fd1374a-132d-fc38-fc96-ed9c98e3ef8c@gmail.com>
Subject: Re: [PATCH 0/3] staging: r8188eu: some minor cleanups
References: <20220602194807.281115-1-martin@kaiser.cx>
In-Reply-To: <20220602194807.281115-1-martin@kaiser.cx>

--------------6WFRi6R0nSoPDdhXDMj27Dzx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTWFydGluLA0KDQpPbiA2LzIvMjIgMjI6NDgsIE1hcnRpbiBLYWlzZXIgd3JvdGU6DQo+
IFNvbWUgbWlub3IgY2xlYW51cHMgaW4gc2V2ZXJhbCBwbGFjZXM6IFJlbW92ZSBzb21lIGRl
ZmluZXMgYW5kIGEgd3JhcHBlcg0KPiBmdW5jdGlvbiwgZml4IGEgcHJvdG90eXBlLg0KPiAN
Cj4gTWFydGluIEthaXNlciAoMyk6DQo+ICAgIHN0YWdpbmc6IHI4MTg4ZXU6IHVzZSBpZWVl
ODAyMTEgZGVmaW5lcyBmb3IgYmFjayBhY3Rpb24gY29kZXMNCj4gICAgc3RhZ2luZzogcjgx
ODhldTogcmVtb3ZlIHJ0d191c2xlZXBfb3MNCj4gICAgc3RhZ2luZzogcjgxODhldTogZml4
IHRoZSBkZWNsYXJhdGlvbiBvZiBwcm9jZXNzX3B3cmJpdF9kYXRhDQo+IA0KPiAgIGRyaXZl
cnMvc3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3X21sbWVfZXh0LmMgICAgIHwgNiArKystLS0N
Cj4gICBkcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19wd3JjdHJsLmMgICAgICB8
IDIgKy0NCj4gICBkcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19yZWN2LmMgICAg
ICAgICB8IDMgKy0tDQo+ICAgZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvaGFsL3J0bDgxODhl
X2hhbF9pbml0LmMgfCAyICstDQo+ICAgZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvaW5jbHVk
ZS9pZWVlODAyMTEuaCAgICAgfCA3IC0tLS0tLS0NCj4gICBkcml2ZXJzL3N0YWdpbmcvcjgx
ODhldS9pbmNsdWRlL29zZGVwX3NlcnZpY2UuaCB8IDIgLS0NCj4gICBkcml2ZXJzL3N0YWdp
bmcvcjgxODhldS9vc19kZXAvb3NkZXBfc2VydmljZS5jICB8IDggLS0tLS0tLS0NCj4gICA3
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+DQoN
ClRlc3RlZC1ieTogUGF2ZWwgU2tyaXBraW4gPHBhc2tyaXBraW5AZ21haWwuY29tPg0KDQoN
Cg0KV2l0aCByZWdhcmRzLA0KUGF2ZWwgU2tyaXBraW4NCg==

--------------6WFRi6R0nSoPDdhXDMj27Dzx--

--------------1xABE6dtyAJLjVB6UXL9h6Z9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmKadIYFAwAAAAAACgkQbk1w61LbBA0Y
8A/9GfWZ2/S3Zy6rjGs71kwX2Gqswq4DXXxjPHztqVD6rS1U/975GtJ749Av4vpNy9RvD1SoZQAv
1qsmKqRjuJZm5/KxaO5NOpvmYrx6ueyDg9eMoRAfg672OvxRt2VPAA/0IP8IZ13jrZzjTrQU0lNu
ITIOht3JoYpE4PSZRpQNDKcgVCbhcJ3mkREv4H4DHsd6civT1gK+LqDu7HOSSF6VgI7skx/Xf5Hh
0Lx4z80WmDCIdCiqfL3wFXnLs02v8fZ5WK23fc6w78GXQU5lmv23+DjMu0C676M8KA+/2vvuxbPe
8aJSpzPYCEnePLNjyphMmgfueYnwCqf7XU9B79h+ZoftQp9EzazxUMkr0ptSQg0/2cbLYMZTCb+C
M0tanoyMtQTcNrwyRIvz4yxYHdtpSZny7zB2Y0qnqR81T36JXRKXkuVd5FO/tiFgOhaPYQaQ5xrg
dh7uEXfBQsG3GnhCjzFlS5HQ+HvEZ3LK5gYsf2VgTpk7XM30Zsqu5WJqwlNQv+9axhBvHx1K8+FY
2DclPuVIAsHKPZDdB0VOJGJveyYcuv9Oby3Dr0XWDTe1X3okpN+euA0O0Lm9I0RS7prj3Cv5JyM4
iZKOH1SI0YahOtLNYSsJNso7Pm6wDfWc6Zy+R82Ey74+z15RTD0ifYoZVZHe7jV/+nlvCywE4Hi2
ZWk=
=uLHL
-----END PGP SIGNATURE-----

--------------1xABE6dtyAJLjVB6UXL9h6Z9--
