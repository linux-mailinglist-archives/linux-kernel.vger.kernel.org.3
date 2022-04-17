Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5250496A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiDQUTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiDQUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:19:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BA92655B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:16:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d6so3839788lfv.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=TX8zh/3mZWRKWsKznABT9xhmhyChqdlG/z1f87PASz0=;
        b=TUYzSB7m/pjZkFBnH1c5tU/zm3kNSZiEYP1SGwC9oPc/VWfEuBLqQ20RZ1Y3VeNQK3
         rgT9dQq8IV+V+uViBxmzMoeGKoD0uG4sbeJ//n9x7qxWByg/CdpAJxDaEo2srNv8e/U5
         I3qMnTaAn2e61F7N2IWQGssE27XNFRZ5hjp0l6yIzyHfUkFPE4pHRJKXDa8SONnmarjA
         1+edZ19hODsca0wsMxIrvHzdXx0nzizO/JgJZX0Zt2baA6mtHf8zzXIodsRe2oNCxiPs
         30ds+oyIusT5uH5iEqOfPzwdbKqSSjDTw6jOquIlA4JLKf7xu6m302piaDsXB1juzRIp
         wK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=TX8zh/3mZWRKWsKznABT9xhmhyChqdlG/z1f87PASz0=;
        b=052M6d9QIxYEQbwQS4otW5yrdxXeiX4Kix3xV+TrXoJUGJEPC5VkNqgg4KaPlCIRRf
         aXlbEby2YolRXUAnZbbmN4prWUWNKs9cfdgKWV4+H6YfWYF0E/tDYw4EV+IUokexSg7Z
         To7zIMxcKdRhs5TgwYM+vynH2l4HOPdRgavLc/sZIWdCqRhKFMJxMO5ypXUL8XORCJda
         efIKMmds2PvuLdSCpE9v1bMs/Z0mUAaeMw3NqUZU7/QOKGbQBc4DPljGuefc3H8RhTMU
         0GiuYBLzarF0bdCGBXNBh4F/+3BW6YZCrj5DnzMFg7POLGMIUnQBLOAwAZx1iqI974MG
         4A2Q==
X-Gm-Message-State: AOAM5303awptazJnANIlnADN6Au6/dGgsU8Eh0qpaemJJtuvdRap/bDv
        os5sH6mGsUerDtulxy8rPAo=
X-Google-Smtp-Source: ABdhPJy6nOOjd66wFL1Q9xgO3LZa0ZswJpL/3uK1QI4Wp1Qcgf91ZV00KNubf2Y/V0jl70YCbhxPgw==
X-Received: by 2002:a05:6512:1526:b0:471:44fa:c367 with SMTP id bq38-20020a056512152600b0047144fac367mr3427689lfb.376.1650226599877;
        Sun, 17 Apr 2022 13:16:39 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id m1-20020a05651202e100b0046cd451b8easm1017044lfq.22.2022.04.17.13.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 13:16:39 -0700 (PDT)
Message-ID: <a28f445f-f088-620e-6baf-4cad3e1a8146@gmail.com>
Date:   Sun, 17 Apr 2022 23:16:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/6] staging: r8188eu: remove unused member
 free_bss_buf
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <cover.1649990500.git.jhpark1013@gmail.com>
 <e41e0d3b62395d04f41d6934074074c431e7aacc.1649990500.git.jhpark1013@gmail.com>
 <3608313.MHq7AAxBmi@leap>
 <20220417201415.GA233554@jaehee-ThinkPad-X1-Extreme>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220417201415.GA233554@jaehee-ThinkPad-X1-Extreme>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nH6u0decmpXWafPdcK1i4ek1"
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
--------------nH6u0decmpXWafPdcK1i4ek1
Content-Type: multipart/mixed; boundary="------------Ozug4Ze70dz3120gvEHLGOWQ";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Jaehee Park <jhpark1013@gmail.com>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
 gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Message-ID: <a28f445f-f088-620e-6baf-4cad3e1a8146@gmail.com>
Subject: Re: [PATCH v2 1/6] staging: r8188eu: remove unused member
 free_bss_buf
References: <cover.1649990500.git.jhpark1013@gmail.com>
 <e41e0d3b62395d04f41d6934074074c431e7aacc.1649990500.git.jhpark1013@gmail.com>
 <3608313.MHq7AAxBmi@leap>
 <20220417201415.GA233554@jaehee-ThinkPad-X1-Extreme>
In-Reply-To: <20220417201415.GA233554@jaehee-ThinkPad-X1-Extreme>

--------------Ozug4Ze70dz3120gvEHLGOWQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmFlaGVlLA0KDQpPbiA0LzE3LzIyIDIzOjE0LCBKYWVoZWUgUGFyayB3cm90ZToNCj4g
TXkgdW5kZXJzdGFuZGluZyBvZiBQYXZlbCdzIHJlc3BvbnNlIGlzIHRoZSBmcmVlX2Jzc19i
dWYgbWVtYmVyIG9mIHRoZQ0KPiBwbWxtZXByaXYgc3RydWN0dXJlIHdhc24ndCBiZWluZyB1
c2VkIGFueXdoZXJlIGFuZCB0aGF0IHRoZQ0KPiBydHdfZnJlZV9tbG1lX3Jpdl9pZV9kYXRh
IGZ1bmN0aW9uIGZyZWVzIHRoZSBtZW1vcnkgb2YgdGhlIHBtbG1lcHJpdg0KPiBzdHJ1Y3R1
cmUgc28gdGhlIHNlY29uZCBjaGVjayBpcyByZWR1bmRhbnQuDQo+IA0KPiBIb3dldmVyLCBh
cyBGYWJpbyBzYWlkLCB0aGUgZnJlZV9ic3NfYnVmIG1lbWJlciBpcyBiZWluZyB1c2VkIGFu
ZCBwYnVmDQo+IG1lbW9yeSBpcyBub3QgYmVpbmcgZnJlZWQuDQo+IFNvIEknbGwgcmV2ZXJ0
IHRoZSBwYXRjaCBhcyBpdCB3YXMgb3JpZ2luYWxseSAod2hpY2ggd2FzIGp1c3QgcmVtb3Zp
bmcNCj4gdGhlIHt9IGFyb3VuZCB0aGUgc2luZ2xlIGlmIHN0YXRlbWVudCkuDQo+IA0KDQpX
aHkganVzdCBgcGJ1ZmAgYWxsb2NhdGlvbiBjYW4ndCBiZSByZW1vdmVkPyBUaGlzIG1lbW9y
eSBpcyBqdXN0IHVudXNlZCwgDQppc24ndCBpdD8NCg0KDQoNCg0KV2l0aCByZWdhcmRzLA0K
UGF2ZWwgU2tyaXBraW4NCg==

--------------Ozug4Ze70dz3120gvEHLGOWQ--

--------------nH6u0decmpXWafPdcK1i4ek1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJcdaYFAwAAAAAACgkQbk1w61LbBA3l
Aw//ULThNHysaIck86TFAUvZ5qKlbZ8At2fGE2odUmUYL+zwMKsMxiJYRh2TbASDEg/8KxsxYY5G
67M042ILhUXZrb3FRsurNzURzF43fz+u2L5fSyYArN1U1mUN3q6tY5H/FLmqIargxv5lYItuT3l9
RvI6JD09W7XCPMA18YtyENdb53nGng/bFdcBdK/ANndHzYc8EGaSFQjYR/buB3rXTwFA1XGBQDMZ
LUNbzP8seAC5j6ahyw2fUUphtKjhaeD+AZbatCaXzNSh0t8jRlpH/AXZtic26MyNQpWeMbXjVRUf
hdh/xM8xacgTJUXXICwEUGLmtT6pIXzN0mxkhbuAYtjEbBhdR1rZcYxT+3g2RIPZB5uX/SGhIBfp
M5X34d5ebNGkRtf+atW3zEcFzzry5YgsgxypoDCEG5SSFgBlhLJpRXVPLW4k0UFgKf+rz50JQpqh
2LLVGvmWlRKV8Fm7Zz7otDsX4u6rZ8O2jDBpQXJHZ1PgNf/Ya3jh6D7mOEQl+UyZTU4nuw6Dncsw
UN9hEWjxbmQh9WzqNIO/urjx6/ASswVi0u7DtiZoVUdCcZYQVHMpEGOwi22bem0+Wt7tehTjUcBl
yxkKST+D0qtV1ljeHusEoJzzmzuG5Dc+vREf2GVftj7Nk98Rgj8xQAWYdkEPZk7IwqQ/NazqxnFX
jns=
=Kl4L
-----END PGP SIGNATURE-----

--------------nH6u0decmpXWafPdcK1i4ek1--
