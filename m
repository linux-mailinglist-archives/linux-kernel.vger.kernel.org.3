Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0216F541FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385802AbiFGWqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379891AbiFGVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:37:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169FA230996
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:05:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l18so12953163lje.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=evvAT7jllA+4Aw94OYgqJpyiRgNgkFxHbYmh9rBab4s=;
        b=BzeiGn7i1N6+YP6ivkPWs3Fk2hG/0/FaKfHAuwfQk49h0hCi504CWK7PIrZbVHZglO
         HPIT9L/KYjam275Ok7UfkpjVFLGlUDk2CAor9Uc4Alfn7xbyaw/Dl2UFET4AjDl13TKH
         talO8NZ0rOg/ePEEYhBb+AaJGDE43OTvyahOfCvH6AkB8pI8UW9d7x/Kr6oWQfHZP1o9
         w4O4sCUmYlCeUOsQKJuAGZPaeARKqaYI6KEgnG9Z2qn7dpUd1XGLbUpa28/GWZqSWpCr
         rRM2UcFX4hf9m4dXJd0FJACO7SVj5vh40hoR/PP99hxFExPBnp1An2K5wHn/ZfnHFsG7
         4cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=evvAT7jllA+4Aw94OYgqJpyiRgNgkFxHbYmh9rBab4s=;
        b=M8zIoRzK8YxyL6CNYVLs5UM7arKljPrRpaUJgJqC2+qIzpeoqwgahy9Fx0KUHoOuj+
         ntJ1H4evdrPParp5O8yP78EEZIvpz0b8nG7r7FSL1Fr+DdEDJz2yRHu8FDL1bIvYnBaG
         OnRDe9TGDdOQWrDYU2sJA21Pex3a810+14epOkT5YPeGVx1xDLLie8GpnKCB6ba3UeJy
         56T+zogf6gZwKf4Es8KHz/G6GOgDaxEES7WE/eUaQOsa+7MwC/kq+jwL6BEAP4av/QPC
         fJTPLJpfOtwDX2ky3iwE76c9YBnwFdqpVLM6jRAVOsMA1xqJnpwJgAyG4vaRW6V7J5/y
         mGww==
X-Gm-Message-State: AOAM532trhrZrwMk0cFF8iPzWQFGMXqSku3+ChSaBr6r8obSTg+Kg+gk
        c01rBcXWwI/WyiLP4GYZ4f8=
X-Google-Smtp-Source: ABdhPJxyRICHVp12VyRxAS6Bj6zHE4Zy2bCjHysRUvaAtTsBqvZfH8CWHLO/BsM+jTWq4TyT8pyh9w==
X-Received: by 2002:a2e:96ca:0:b0:255:bc31:b200 with SMTP id d10-20020a2e96ca000000b00255bc31b200mr1573848ljj.241.1654628699733;
        Tue, 07 Jun 2022 12:04:59 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id o14-20020ac25e2e000000b0047255d210d6sm3395990lfg.5.2022.06.07.12.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:04:57 -0700 (PDT)
Message-ID: <f2cdd4ae-f273-0510-9a58-1ed56f456893@gmail.com>
Date:   Tue, 7 Jun 2022 22:04:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 0/4] staging: r8188eu: add error handling of usb read
 errors
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1654543286.git.paskripkin@gmail.com>
 <Yp8xezHITGrxv47H@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Yp8xezHITGrxv47H@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TxZoTQhvn8HfeZ0cwzX26M3g"
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
--------------TxZoTQhvn8HfeZ0cwzX26M3g
Content-Type: multipart/mixed; boundary="------------iBK0aRRty3uHOj0TId0Taeg0";
 protected-headers="v1"
From: Pavel Skripkin <paskripkin@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
 straube.linux@gmail.com, dan.carpenter@oracle.com,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Message-ID: <f2cdd4ae-f273-0510-9a58-1ed56f456893@gmail.com>
Subject: Re: [PATCH v3 0/4] staging: r8188eu: add error handling of usb read
 errors
References: <cover.1654543286.git.paskripkin@gmail.com>
 <Yp8xezHITGrxv47H@kroah.com>
In-Reply-To: <Yp8xezHITGrxv47H@kroah.com>

--------------iBK0aRRty3uHOj0TId0Taeg0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR3JlZywNCg0KT24gNi83LzIyIDE0OjA3LCBHcmVnIEtIIHdyb3RlOg0KPiBBZnRlciBh
cHBseWluZywgSSBnZXQgdGhlIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nIHdoaWNoIGJyZWFr
cyB0aGUNCj4gYnVpbGQ6DQo+IA0KPiBkcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0
d19tbG1lX2V4dC5jOjY4MjY6MTM6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYcmVz4oCZ
IFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0NCj4gICA2ODI2IHwgICAgICAgICBpbnQgcmVz
Ow0KPiAgICAgICAgfCAgICAgICAgICAgICBefn4NCj4gDQo+IFBsZWFzZSB0ZXN0LWJ1aWxk
IHlvdXIgcGF0Y2hlcyBiZWZvcmUgc2VuZGluZyB0aGVtIG91dCA6KA0KPiANCg0KV2FzIGN1
cmlvdXMgYWJvdXQgd2h5IG15IGNvbXBpbGVyIGRpZG4ndCB5ZWxsIGF0IG1lIGFib3V0IHRo
YXQgaXNzdWUsIA0Kc2luY2UgSSd2ZSBkb25lIG5vdCBvbmx5IGJ1aWxkIHRlc3QsIGJ1dCBh
bHNvIHRlc3RlZCBvbiByZWFsIGh3Li4uDQoNCkJ1aWxkIGZhaWx1cmUgb2NjdXJzIHdoaWxl
IGFwcGx5aW5nIDEvNCwgYnV0IDMvNCBmaXhlcyBpdCwgdGhhdCdzIHdoeSBJIA0KbWlzc2Vk
IHRoYXQgYnVpbGQgZXJyb3INCg0KQW55d2F5LCBpdCdzIG9ubHkgbXkgYmFkLiBTb3JyeSBh
Ym91dCB0aGF0LCB3aWxsIGZpeCB1cCBpbiBuZXh0IHZlcnNpb24uDQoNCg0KDQoNCldpdGgg
cmVnYXJkcywNClBhdmVsIFNrcmlwa2luDQo=

--------------iBK0aRRty3uHOj0TId0Taeg0--

--------------TxZoTQhvn8HfeZ0cwzX26M3g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEER3XL3TplLQE8Qi40bk1w61LbBA0FAmKfoVgFAwAAAAAACgkQbk1w61LbBA1m
uw//T2hXSY2RUsTo2+mmCiFIHGXap9QQnVuNiQLdxc1jTRkuFKpcs58VWx3Gcc3lhnWfLg0ATYqw
epip20G+YAG3hMUjT1Z3VmZx34S+SINdTuiYeXlp55lu08JnNnoeB62gXR5SOvL3Bl+wVFMOTJ/M
d1oYnmn3CHlJDOGUv7pgJ45mVpcwOXGmoqf2ChOsRYfufwUlgJPcWPJPnD6gXMcNDtSfYPVBVDbO
CV3rH5zMFz9zCz/RvuSuzM6JDlYJj3mQIK8gme1G10zMAymq3/nxmX9xjvDRXUHYwevDsRngRnN+
Cv0y7uJkpf1XA5hJIeRHHXvd9FHwthqKsZPeKH0UR2fef0ris+HDs6s5/OEsnmh0Qh8mYos1PUrm
K1w8IvQ87PMWEUaY3vh9eCWBS1CfNJq5SOyBZ+eRjO7VOS3sD+47OCk3ySZDG7hlsVgrfFZtbC33
OCnLf5RnVxJyMMN/88Yp2wg07oF92cpY3V01vIvOGfvFX1UisvTXALhdusrZU0gaGZrs/BQhFJ9v
oiYNpX8DNm78BcQXAr3dFQxDxdoXfUR1ZgVS5thBpWqftVpQOOVXuxnXh1V/AaSNo1cJmbtVJpov
bTwZ8gDMZ3xJ18lT9IzqtMcEyqTtbExdfdfHM7Fzs29h2ggZqTaR+QzRwGE2Ck3CUZaghtZv4i61
nEc=
=Os/W
-----END PGP SIGNATURE-----

--------------TxZoTQhvn8HfeZ0cwzX26M3g--
