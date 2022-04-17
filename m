Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E05048D1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiDQSPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiDQSPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:15:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34184BCBA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:13:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b21so21320523lfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=9701YZ/xHH6MCgb4Xa3q1CBlV3+XhybZ5TzrqerWZBw=;
        b=CVfHZxYFYYA9CdMbeAV053SoAVCF/tXf6PcjGBQmj+0UAn2UyxiSjaNW16N89i9Mby
         pWVpKIpPIvps0k48pK9Pdy6usX1ydhkYk05C9MDChF5bsycBtydY2mOvOHVe8Pe2uCAR
         pfKMB713TCSx9Qan2O9xvxGiicEauozvtV1nAvy91EjHl7Xu+wa6bQhhsuu1c9Thurme
         F2UCIrmEbWpfTJN5enLGZf9ShmLju8rWd8WqSO0mgabUys5mScKLsbqsSQh6bcSWQgXW
         AWt5t0CfQWJ+Fu6OmOKVGLr0TnwZFuR6Pnbz+GZ0SuzZYY8sqavcwWvSOTv+nqEn9zzv
         mpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=9701YZ/xHH6MCgb4Xa3q1CBlV3+XhybZ5TzrqerWZBw=;
        b=bOajBq30Ro5y8/MegZ05BqCOmRgSIKxx7QouIgXi5W0kepT4wveiWA/NfhaajSAp/5
         +E9KpSFPjJChU+wFLTsmChm/PorYdbdKTf3GBZ5QikKZ4VD4SwkkhjXAhv6WSX+QFkfS
         0OfIhl6wq+Nw0WQa+U+fhTqwS5ND3rB6R1u7YC5Oe/Rm2S3gsEFYGFnXTwB/cRLqMSuz
         jAgJafKP63ACUc6mQ1gjpzJd1yw6DCH2qVMDDWKnKqSoMGqPovPyp94LkEEo8C8ZoXBG
         d1b/2xzR9p2hcx3IvDlGGQYET0WChoIdfcPlHF3LKxnQ3s4SyJgq7XIVBz88/h7kHor3
         63fg==
X-Gm-Message-State: AOAM531lekQcD4HHmOVN57qZu4VkzWHR1VRUVlTfiu5NcNnGJArSctp2
        UpIevdq8bnXjhA68sSwo9pTw+GJhP8g0fw==
X-Google-Smtp-Source: ABdhPJyodLEq5mywD6kQl7ZSRtLytAmtkbTeq+hLYk8AQpWYrX/cuxZ6Xzq+kXlrg5ZXscWQ9IA82A==
X-Received: by 2002:a05:6512:b1b:b0:44a:9ae9:b9bf with SMTP id w27-20020a0565120b1b00b0044a9ae9b9bfmr5468913lfu.365.1650219193212;
        Sun, 17 Apr 2022 11:13:13 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id k30-20020a192d1e000000b0046e638e6263sm964446lfj.198.2022.04.17.11.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 11:13:11 -0700 (PDT)
Message-ID: <6c29201d-a717-9ce3-21c0-6c663fc9add3@gmail.com>
Date:   Sun, 17 Apr 2022 21:13:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] r8188eu: remove unused urbs from struct xmit_buf
Content-Language: en-US
To:     Ivan Safonov <insafonov@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220417163608.42917-1-insafonov@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220417163608.42917-1-insafonov@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------28lPK9q4R0bjW0PntMF0jMZN"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------28lPK9q4R0bjW0PntMF0jMZN
Content-Type: multipart/mixed; boundary="------------El2pSdO0kvgTFtyzX8aPf5SB";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Ivan Safonov <insafonov@gmail.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Phillip Potter <phil@philpotter.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Straube <straube.linux@gmail.com>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
 Martin Kaiser <martin@kaiser.cx>, Cai Huoqing <cai.huoqing@linux.dev>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <6c29201d-a717-9ce3-21c0-6c663fc9add3@gmail.com>
Subject: Re: [PATCH] r8188eu: remove unused urbs from struct xmit_buf
References: <20220417163608.42917-1-insafonov@gmail.com>
In-Reply-To: <20220417163608.42917-1-insafonov@gmail.com>

--------------El2pSdO0kvgTFtyzX8aPf5SB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSXZhbiwNCg0KT24gNC8xNy8yMiAxOTozNiwgSXZhbiBTYWZvbm92IHdyb3RlOg0KPiBE
cml2ZXIgYWxsb2NhdGVzIGVpZ2h0aCB1cmJzIHBlciB4bWl0X2J1ZiwgYnV0IHVzZXMgb25s
eSBmaXJzdCB1cmIuDQo+IEFsbG9jYXRpb24gb2Ygc2V2ZW4gcmVtYWluaW5nIHVyYnMgd2Fz
dGVzIG1lbW9yeSBmb3Igbm90aGluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEl2YW4gU2Fm
b25vdiA8aW5zYWZvbm92QGdtYWlsLmNvbT4NCg0KdGhhbmtzLA0KDQpSZXZpZXdlZC1ieTog
UGF2ZWwgU2tyaXBraW4gPHBhc2tyaXBraW5AZ21haWwuY29tPg0KDQoNCg0KV2l0aCByZWdh
cmRzLA0KUGF2ZWwgU2tyaXBraW4NCg==

--------------El2pSdO0kvgTFtyzX8aPf5SB--

--------------28lPK9q4R0bjW0PntMF0jMZN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJcWLUFAwAAAAAACgkQbk1w61LbBA27
jhAAq1+AA0R5XE1jSQZvntbGdgkcpEpP7fjX1wF5Ezp6U2/O9ywLkzk9wBM+VsfgzsKAWHL8xgmi
eMooAxA/p/dCVTuOTpk/EV8buRHdfzpiVuSnOtmFjMNU1aP72ji5Qe0WaTZZnhln4o6smp1yWF00
4qgCe8w3C/YXrFY4OAP+LV63gCF6XVG3EtVpw5Qc7LIDJ8/E51ls9UqImN6p4PQK3dQy26XkoWoB
T/vNC0FFm3rBZZbbclr51tysH1ujZyF9Wg3E3AvgQr0Sb6jbt+ROv6vrNk5L+c0MPd5bsRZoo5fn
61d/GO0spXx5mFCpXuMeKUrx/RkTw1bUMIT6b0pAO14E7X35ZUtsVo3dl32TKAlOqXul6n/Xl4mX
G48DcWmDk49/xzTxks32ZMFkTLIV6zG1oD8G6qJcjGnfXtjAIiqd33DedWZkto005zC94eng5kWi
Aj627U+yvDOgGTEaK4lVTbbGdURpogCI/7oTvX7O4/rcMz3+z4pn2UsnKWkYXn8s7PNc2wPhlk1p
g40+n5dk7jlRA3KLfK8Wh/lPPq65Gix3AGwgAjVEO4Nu97/xOtqDr0xTvoIBMlxT9+QkL4hFNbP9
9XuW/6tgkLuQZat002k5XQDwq35JB0Gwv66FN3tw01EERvyktILqi1TKIRoRO3VEc7Ky/Gw6A2RB
09k=
=giYe
-----END PGP SIGNATURE-----

--------------28lPK9q4R0bjW0PntMF0jMZN--
