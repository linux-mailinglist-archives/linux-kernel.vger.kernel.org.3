Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6F5501C37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiDNTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiDNTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:53:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0C6DA09C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:50:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p10so10842451lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=TdxkH2djTgZuMcjVKrm/SY7bnf6WgvoV4fF2I+4K2jA=;
        b=QNoOWdhcQK0IvmGTfBjoDqreiKJE/oFCC61Uuba9orHB8IThwi59sLhp+G9fbxfsdR
         hgMi/+832NTkV9ghFrqA7HEJw3awgLjqF0PMatdcHBtsjp4lSETGtt5NO4bN77CnYSAp
         njlhG6xO7L5ji202LnuM7gUPGc6d4lZ/l0Pa4Qg2DchNqN1wqin5zTge1QKDjrZYON+L
         1rJxW+uvfm3vyVDINyuGdsEkrTbwE37as3LtFMhFbsK+vO2jawKD1zs55y7m85bz3zM/
         cBvQ+9ZY73Nn6ZNWhUz7A1E2mVN7Tsnr1PREBOJWPWhZqxWoMJElRdAmWVl5cfCg2Xq4
         6MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=TdxkH2djTgZuMcjVKrm/SY7bnf6WgvoV4fF2I+4K2jA=;
        b=w4E3EOOLNaj8+NjkNDBZpuvlO21l0U8hlnet5K6gnYCGktFj7C7dlIDazjVI5GKSkj
         xJ2XBkTb+ZXVAZkwoBA17fLZb6iivpd3u0jjUbef/bVG665kTeC1qZQUZUCkjfBWtOJG
         IabJVckciZSNr1ybvWrpJNNevwunYsbz8bKwCrEXBIHlfOjf+xccj5al7ciT9W7purg3
         9sgg30lOjxa37OrJ1FQ+PZjXmVcapnhFZvcs1iuQjAT+LiYxZ0k3OC8puGJi4nxS9T1f
         kI3iHxwquXTWwWaDPDjC/XOvKBj6GwDwc3NpbHprv3N/cMcuqjfogTDUNrzJgUoPyebe
         7aeg==
X-Gm-Message-State: AOAM5337iLJcuAeqkXohLGzrrchj6v3zuy9b0NAC6180z7m5uLH/BdMw
        TOwiH5nLttg97GDtWp7BfCkC7uSSPdajIA==
X-Google-Smtp-Source: ABdhPJz2ad/ZU205Y5+H2UWRdUffCIUQQJjXTSCsyj+hG1X5TVN7eGRxzHbPZg4d3fsD+DMf5/gSrA==
X-Received: by 2002:a05:6512:2242:b0:46b:92d3:e2e9 with SMTP id i2-20020a056512224200b0046b92d3e2e9mr2828599lfu.290.1649965854054;
        Thu, 14 Apr 2022 12:50:54 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id h24-20020a2eb0f8000000b0024b578bba76sm83428ljl.26.2022.04.14.12.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:50:53 -0700 (PDT)
Message-ID: <8bd1cc3c-c28b-b30f-d9ff-04f9a3c79646@gmail.com>
Date:   Thu, 14 Apr 2022 22:50:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/6] staging: r8188eu: remove unnecessary braces in single
 statement block
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <4a0f2a0f24321c5b2039f0f8e6132cec4a2ef068.1649880454.git.jhpark1013@gmail.com>
 <3f4a6c08-4434-1865-bc96-984152af5af1@gmail.com>
 <20220414194118.GA4144553@jaehee-ThinkPad-X1-Extreme>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220414194118.GA4144553@jaehee-ThinkPad-X1-Extreme>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nB6Pa0fPnHpxIEUshLzMoYZL"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nB6Pa0fPnHpxIEUshLzMoYZL
Content-Type: multipart/mixed; boundary="------------9hX0rWtZTks0Hqcd23Ni7pPC";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Jaehee Park <jhpark1013@gmail.com>
Cc: Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
 gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Message-ID: <8bd1cc3c-c28b-b30f-d9ff-04f9a3c79646@gmail.com>
Subject: Re: [PATCH 1/6] staging: r8188eu: remove unnecessary braces in single
 statement block
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <4a0f2a0f24321c5b2039f0f8e6132cec4a2ef068.1649880454.git.jhpark1013@gmail.com>
 <3f4a6c08-4434-1865-bc96-984152af5af1@gmail.com>
 <20220414194118.GA4144553@jaehee-ThinkPad-X1-Extreme>
In-Reply-To: <20220414194118.GA4144553@jaehee-ThinkPad-X1-Extreme>

--------------9hX0rWtZTks0Hqcd23Ni7pPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmFlaGVlLA0KDQpPbiA0LzE0LzIyIDIyOjQxLCBKYWVoZWUgUGFyayB3cm90ZToNCj4+
ID4gQEAgLTExMiw5ICsxMTIsOCBAQCB2b2lkIF9ydHdfZnJlZV9tbG1lX3ByaXYoc3RydWN0
IG1sbWVfcHJpdiAqcG1sbWVwcml2KQ0KPj4gPiAgIAlydHdfZnJlZV9tbG1lX3ByaXZfaWVf
ZGF0YShwbWxtZXByaXYpOw0KPj4gPiAtCWlmIChwbWxtZXByaXYpIHsNCj4+ID4gKwlpZiAo
cG1sbWVwcml2KQ0KPj4gPiAgIAkJdmZyZWUocG1sbWVwcml2LT5mcmVlX2Jzc19idWYpOw0K
Pj4gPiAtCX0NCj4+IA0KPj4gSWYgcG1sbWVwcml2IGlzIGVxdWFsIHRvIE5VTEwgd2Ugd291
bGQgZGllIGluIHJ0d19mcmVlX21sbWVfcHJpdl9pZV9kYXRhKCksDQo+PiBzbyB0aGlzIGNo
ZWNrIGlzIGp1c3QgcmVkdW5kYW50DQo+PiANCj4gDQo+IEhpIFBhdmVsLCB0aGFuayB5b3Ug
Zm9yIHlvdXIgY29tbWVudCEgSWYgSSdtIHJlbW92aW5nIHRoaXMgaWYgc3RhdGVtZW50LA0K
PiBzaG91bGQgSSBpbmNsdWRlIHZmcmVlKHBtbG1lcHJpdi0+ZnJlZV9ic3NfYnVmKSBpbg0K
PiBydHdfZnJlZV9tbG1lX3ByaXZfaWVfZGF0YT8NCj4gDQoNCkhtDQoNClNpbXBsZSBncmVw
IHNob3dzLCB0aGF0IHRoaXMgbWVtYmVyIGlzIGp1c3QgdW51c2VkDQoNCjEgZHJpdmVycy9z
dGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfbWxtZS5jfDY0IGNvbCAxM3wgDQpwbWxtZXByaXYt
PmZyZWVfYnNzX2J1ZiA9IHBidWY7DQoyIGRyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2NvcmUv
cnR3X21sbWUuY3wxMTYgY29sIDIwfCANCnZmcmVlKHBtbG1lcHJpdi0+ZnJlZV9ic3NfYnVm
KTsNCjMgZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvaW5jbHVkZS9ydHdfbWxtZS5ofDMyMiBj
b2wgNnwgdTggKmZyZWVfYnNzX2J1ZjsNCg0Kc28gbG9va3MgbGlrZSB5b3UgY2FuIGp1c3Qg
cmVtb3ZlIGZyZWVfYnNzX2J1ZiBhbmQgYWxsIHJlbGF0ZWQgbGluZXMuDQoNCkkgaG9wZSBJ
IGhhdmVuJ3Qgb3Zlcmxvb2tlZCBzb21ldGhpbmcNCg0KDQoNCldpdGggcmVnYXJkcywNClBh
dmVsIFNrcmlwa2luDQo=

--------------9hX0rWtZTks0Hqcd23Ni7pPC--

--------------nB6Pa0fPnHpxIEUshLzMoYZL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmJYexwFAwAAAAAACgkQbk1w61LbBA0t
DQ//TVj2tLGoN0T2zaDleQcCNigtX/Ni3eW0Nozeevmon7zqjdfs/1yNgU12AmGD5Eok6ZTnUb1e
CC1XhxYHSvbj8Zva2h6MQDSJgzbQq7Hn4UbNgtQMDLIUlkNTjQBojzuL2XnbKHZEJBAPOkmT210I
JHLSmDC0AATaTn8wQUNDaH+aNe9fn3G2x/YHxwUZnnsysJpRWmRB024bgJ0dMSgy0M5vBxVoAuj9
gzBcXqEGDfxw38l1iNM/mEU4lfhjbQqikK6rnKLaQcXvc1/EeBhvzA3GWNQo4y6qu7p53Eu8rYnC
mUVBJGTc7EY8iAElJ2z4nOfSinId/Wg/K1tVii1X0s1W4Ur5TTWvlYYNYf8Q8wKmKOtC31aFB0p/
SLRsgmT1VQZG0W2wJasmeiFZ0nNcwdp7RUayhOtpNXu2RB/5z8uFxpXNlVxeR76/fXV8BI4EiuyA
oiurW5TcxRUBdRZbkEKc+fssvIEpTF24KrFFB5rBtJV5SfmfWR+N/K/RRXPgoruUIpbkA/BFDD4f
XEn+dAfTAR4fjVaFeTin/t41afwAKy5MqseZ4ohpPCzAVMpGZQ2puyCRmPXI5dHBGfartEIEP1f4
pHpV8gaPKBxrWgMFPQIk2XzbdSdAIGJt8QmcWoM+xQnja6rEbjs+r4PcPe3WAPEdQmgnFNZgWY9B
L4A=
=R8Pp
-----END PGP SIGNATURE-----

--------------nB6Pa0fPnHpxIEUshLzMoYZL--
