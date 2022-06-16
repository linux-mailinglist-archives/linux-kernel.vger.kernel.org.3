Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1654D9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358435AbiFPF17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiFPF15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:27:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A71707C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:27:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so2209473wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references
         :content-language:from:autocrypt:subject:in-reply-to;
        bh=hTCJbK3AP3veAPqUtya3nfn5p9r9O0hHB9bgO/mKuVw=;
        b=iKoxaFPYbN+el1uVlf2f5Dw+uyBhRQBfr4RNtvfYfs1q4Tdff0HS47GWmb9wLvetta
         mT6mlFlKvwoHmxCvqSr8b+hrMqaQhIgLZyE//T7dH63Nz9huVRAToPclsZzaAPJbG1xC
         ZnG7baYubEkh1oYlhWlEbUGxuZL5vVozR768klVWIrDt+1Zsx7iaXEgur540bcStz+U0
         JLQMax6fxBY8eC5jgne6npIsNQWEUgHWy/eaGhEHw+TtrH1pGoBs8WuBJ8AoMD4GokYe
         Sh/OmOJTXzNt6vaOq1q22rSqcX56lYUguMAd/zfGFPUUcrH28zLFamBTScM/a+EnDXN1
         1fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:content-language:from:autocrypt:subject:in-reply-to;
        bh=hTCJbK3AP3veAPqUtya3nfn5p9r9O0hHB9bgO/mKuVw=;
        b=eGhYcWjZalzOSdLX3FIwkVlMkBsGhhVRsMUMeBgP2S4uUGYJ+TsyL2Q6dyfqVSSBI3
         F8EyVES7WNSu9JzfJ8Hht/BEJ6blH3uSvOBCwBsZu5B69zBCFS40stI36hkTzJ7+VxtJ
         IQP0Fgf+OetgTC/1YW7RD5FbgIpRwdMmfYr8AG/hqgylKPNCTRBa4A0BWqJEW7cbaZRY
         WEh03zEpQ8RwF62rE0/NUlXzHhDdFoDvEBXRAMOixhJUSX0ES2QP2wuvq3cNaOq/GqHa
         Qao2/PYo5RInIj0kWfinrutOWhor9ozI7eTAhwhxOGKvQczB56gUmHZfAzR7cHqYjmwP
         GhCQ==
X-Gm-Message-State: AOAM5320LfBoyjDiSbY+2qha5zJjd8fwQpL9HxkJwRXX40Lvp69ZuBmb
        gcXnYpn9GUNDMDlKAbEiDFHEmipwn1qA9cvP
X-Google-Smtp-Source: ABdhPJy5UuPRJYxaF1cIgo+srGfVU6+3efvfloLhd19hVILD3fs1D5j3OXRhyOFepcKfqpKBKi/koA==
X-Received: by 2002:a7b:c3cd:0:b0:39c:474b:2056 with SMTP id t13-20020a7bc3cd000000b0039c474b2056mr13679984wmj.30.1655357271486;
        Wed, 15 Jun 2022 22:27:51 -0700 (PDT)
Received: from [192.168.2.172] (dynamic-077-190-073-123.77.190.pool.telefonica.de. [77.190.73.123])
        by smtp.gmail.com with ESMTPSA id j14-20020adfa54e000000b0020fd392df33sm778324wrb.29.2022.06.15.22.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 22:27:50 -0700 (PDT)
Message-ID: <3f8d25aa-17a6-e6aa-4b6d-d3388ef35201@gmail.com>
Date:   Thu, 16 Jun 2022 07:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, christian@brauner.io, hch@lst.de,
        hridya@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com,
        surenb@google.com, tkjos@android.com
References: <YjCTL/2ZJW8EWLHL@kroah.com>
Content-Language: en-US
From:   =?UTF-8?Q?Hans_M=c3=bcller?= <schreibemirhalt@gmail.com>
Autocrypt: addr=schreibemirhalt@gmail.com; keydata=
 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
Subject: Re: [PATCH] staging: remove ashmem
In-Reply-To: <YjCTL/2ZJW8EWLHL@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rdffJepB2c23g2c09LE3DkCY"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rdffJepB2c23g2c09LE3DkCY
Content-Type: multipart/mixed; boundary="------------tz01mBP1x6oPmFzywWAkvx00";
 protected-headers="v1"
From: =?UTF-8?Q?Hans_M=c3=bcller?= <schreibemirhalt@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arve@android.com, christian@brauner.io, hch@lst.de, hridya@google.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 maco@android.com, surenb@google.com, tkjos@android.com
Message-ID: <3f8d25aa-17a6-e6aa-4b6d-d3388ef35201@gmail.com>
Subject: Re: [PATCH] staging: remove ashmem
References: <YjCTL/2ZJW8EWLHL@kroah.com>
In-Reply-To: <YjCTL/2ZJW8EWLHL@kroah.com>

--------------tz01mBP1x6oPmFzywWAkvx00
Content-Type: multipart/mixed; boundary="------------G6OBZFvi9rlv9Cn3tatVlMdv"

--------------G6OBZFvi9rlv9Cn3tatVlMdv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SXQgaXMgbm90IG9ubHkgQW5kcm9pZCBpdHNlbGYgdGhhdCBicm9rZSBidXQgYWxzbyBBbmJv
eCANCihodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9BbmJveCk6IA0KaHR0cHM6Ly9n
aXRodWIuY29tL2FuYm94L2FuYm94L2lzc3Vlcy8yMDQyDQoNCkkgdXNlIHRoYXQgcmVndWxh
cmx5IG9uIG15IHN5c3RlbS4uLiBJIGtub3cgdGhlcmUgaXMgV2F5ZHJvaWQgYW5kIEkgZG8g
DQp1c2UgaXQgc29tZXRpbWVzIGJ1dCBpdCBpcyBub3QgYSBmdWxsIHJlcGxhY2VtZW50IChl
c3BlY2lhbGx5IHNpbmNlIGl0IA0KbWFrZXMgdGhlIHdob2xlIHN5c3RlbSBzbG93ZXIgb3Zl
ciB0aW1lIGFuZCBzcGFtcyB0aGUgdHR5KS4NCg0KQ291bGQgeW91IGNvbnNpZGVyIHJldmVy
dGluZyB0aGF0IGNoYW5nZSB1bnRpbCB0aGUgQW5ib3ggcGVvcGxlIGZvdW5kIGEgDQp3YXkg
d2hpY2ggYWxsb3dzIEFuYm94IHRvIG5vdCBkZXBlbmQgb24gYXNobWVtIGFueW1vcmU/DQoN
Cg==
--------------G6OBZFvi9rlv9Cn3tatVlMdv
Content-Type: application/pgp-keys; name="OpenPGP_0x92494CB870D3918B.asc"
Content-Disposition: attachment; filename="OpenPGP_0x92494CB870D3918B.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3D9G6D
-----END PGP PUBLIC KEY BLOCK-----

--------------G6OBZFvi9rlv9Cn3tatVlMdv--

--------------tz01mBP1x6oPmFzywWAkvx00--

--------------rdffJepB2c23g2c09LE3DkCY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+zpgzvChJL/lYUStkklMuHDTkYsFAmKqv1UFAwAAAAAACgkQkklMuHDTkYsI
pxAAgBr9jrGWPIFJ6auyJLvI65FBHLksj0AqznfsSoEyfKM8ezee2G1Ld/0ndyoLjonGy0TZYeBs
SPBUPZUnydt7CAqNfks4LRqigXjLKB21UzZ1EaPorXWlZGOPkKflWAQtNxUOiU4DwJbVVCMG+Btb
Py2ai0OGQkG+xNWRaRoQUfCOwiR0twtVdwKBSYtZ2QapsLpL+kR9QDGOVFNg7hBs+kkCX4E1zRR0
SYHzGzyyYaGPbfqki9cGTbF4u6i7uxbBzfTnExZ3x21OJ7N+shq1RfvsGLLMhRlddJtJuBjdLFpb
tOrJWcWEvJT5r/L71Lx1ytguuJCKEhpuMvDrTnaTTo87cv+td3gJxArUWimk6HoZNN1LnzeboJQT
h4bhGn18UVyc7lz9yH23g7aSLDCY/cKJM9RIQ99v97W/zWRz7awe8uRSB49Ztr/KsY3u6vPeGbvv
1VZVUbUG5vfGH29HM4Ja0IuML2kqWgC51r9zueEE2err9j7cb2NihdIkeHfXfCs6FeBtv+1B88gu
bRizvVhrRCNpYwkHxdGCv86y9rGBtHQjCLwaHdYAwGcDusToOn7RL5M4bTbnUo3pU3Islnaa4Bg1
NxeIAWjrWiJHqXcePKZ/9Wxh7x4rg+ljw17fTeELHhQegvdu/ZJ/Nb6Ofs1mSpy1zAiIcrOra4Aq
sAs=
=7Rlk
-----END PGP SIGNATURE-----

--------------rdffJepB2c23g2c09LE3DkCY--
