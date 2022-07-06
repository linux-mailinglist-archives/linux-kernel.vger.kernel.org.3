Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08402567DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGFFnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiGFFn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:43:27 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9F621B1;
        Tue,  5 Jul 2022 22:43:25 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id k2so4451538vsc.5;
        Tue, 05 Jul 2022 22:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIOkUw7/dlHm3PcGuFymF+vCzjdxBhtSSgiqGtBYXiQ=;
        b=I3Iz+MxDdhm373RRIJcbmItmN/ua36cpm/BeKMPN5VyAT5jbIzp8HWa9fWpICvcLWd
         AOnocrViL9yt5l5vUHDfWTsC17LC4iC6HrKFAFtctTvRH2M6p3c/t2cRdVix+WaaRpYH
         jXbZbeaYNJHpYbwaXvuFBLbtdWqj70Ix/6zWEyIrbOWSkFDzk1WUkOnuaF6+F4/z3bMh
         fqpXuC1h0Q38suR5lEOqJSsn5wfYlecBSG5D/jesJ4a+8cIB4Cpw95tDjqt6VrH3pLqX
         XYAsmzlwndRoYUHhkq8pITwrB3x6uLe/dWbFf80ZiSJzlfPz5DPN/MIbtjyIZBo+vhST
         Y0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIOkUw7/dlHm3PcGuFymF+vCzjdxBhtSSgiqGtBYXiQ=;
        b=I08c2Ajxdm26NzDpqJeiMPwTEr5fIWjYsLPZyO3AvpEiRjMNC+YoHfKWISJYQkOOhH
         RLIA+sjP3vIUjadlkQJe44pM7i8RMafXw4bSDicIdcMjNoKbOdZCVZNqD7X/7Q9M7h0g
         mkgTU3VMUP/vaOb7Jg67DuUhLaXeqgGc6futMjgFMyVRz5IKXUCST14HE0qE/BOiAJlu
         2UUd70vcwAYo9BqUftp1u7FvQV0QMFe2Kzr1mCI/o6DWJ3dPUJzZzxXAs3grPitGBADm
         AgGKGfNsroRBmUtbntlcgF1bvFjQ8RFVWB88A8cfnJL+uKpuXz55+45edm5ccvXrTboB
         H/bQ==
X-Gm-Message-State: AJIora+rDQ94SsO8DUfziwzwbXw38/C2mWw+VPmB6rnMG2xroY8g1aXH
        1ZKWyKFEQAIwabFExywCSyu2qFuQbzVxxFGK/Ho=
X-Google-Smtp-Source: AGRyM1vtEv36+/l3kyHi4TrW3Gt1AiE+ohsURl/fFHhJfmeE1mCtzV4wy5I6XK8KydJAHLVlBB6cGRfJSKXPrQLoXoU=
X-Received: by 2002:a67:fe50:0:b0:356:a09d:afe4 with SMTP id
 m16-20020a67fe50000000b00356a09dafe4mr11184102vsr.6.1657086204563; Tue, 05
 Jul 2022 22:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220706080615.11c5ede3@canb.auug.org.au> <TY2P153MB0238EBC99422B2008BA0916C94809@TY2P153MB0238.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <TY2P153MB0238EBC99422B2008BA0916C94809@TY2P153MB0238.APCP153.PROD.OUTLOOK.COM>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 6 Jul 2022 00:43:13 -0500
Message-ID: <CAH2r5mswhV-0b2R4jaxXC1LoRGc7DjpB0ezxGWdJ3Me5=01Wpg@mail.gmail.com>
Subject: Re: [EXTERNAL] linux-next: Fixes tag needs some work in the cifs tree
To:     Shyam Prasad <Shyam.Prasad@microsoft.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000095e97a05e31c721b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000095e97a05e31c721b
Content-Type: text/plain; charset="UTF-8"

Fixed

(updated patch also attached)

On Wed, Jul 6, 2022 at 12:37 AM Shyam Prasad <Shyam.Prasad@microsoft.com> wrote:
>
> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Wednesday, July 6, 2022 3:36 AM
> To: Steve French <smfrench@gmail.com>; CIFS <linux-cifs@vger.kernel.org>
> Cc: Shyam Prasad <Shyam.Prasad@microsoft.com>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux Next Mailing List <linux-next@vger.kernel.org>
> Subject: [EXTERNAL] linux-next: Fixes tag needs some work in the cifs tree
>
> Hi all,
>
> In commit
>
>   37c1ad516f2c ("cifs: fix race condition with delayed threads")
>
> Fixes tag
>
>   Fixes: 37d488b3d38c ("cifs: change iface_list from array to sorted linked list")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: aa45dadd34e4 ("cifs: change iface_list from array to sorted linked list")
>
> --
> Cheers,
> Stephen Rothwell
>
> -------------------------------------
>
> Good catch. I must have used a different branch.
> Steve, can you please fix the SHA1 in your branch?
>
> Regards,
> Shyam



-- 
Thanks,

Steve

--00000000000095e97a05e31c721b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-fix-race-condition-with-delayed-threads.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-fix-race-condition-with-delayed-threads.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l596bzsh0>
X-Attachment-Id: f_l596bzsh0

RnJvbSBhYzEyNWQ5M2FlOTJkOWE1NWRiMzVjNTZlODYwNjU4YjUzMjA4ZjAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBUdWUsIDUgSnVsIDIwMjIgMTE6MTY6MjQgKzAwMDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gY2lmczogZml4IHJhY2UgY29uZGl0aW9uIHdpdGggZGVsYXllZCB0aHJlYWRzCgpPbiBmYWls
dXJlIHRvIGNyZWF0ZSBhIG5ldyBjaGFubmVsLCBmaXJzdCBjYW5jZWwgdGhlCmRlbGF5ZWQgdGhy
ZWFkcywgd2hpY2ggY291bGQgdHJ5IHRvIHNlYXJjaCBmb3IgdGhpcwpjaGFubmVsLCBhbmQgbm90
IGZpbmQgaXQuCgpUaGUgb3RoZXIgb3B0aW9uIHdhcyB0byBwdXQgdGhlIHRjcCBzZXNzaW9uIGZv
ciB0aGUKY2hhbm5lbCBmaXJzdCwgYmVmb3JlIGRlY3JlbWVudGluZyBjaGFuX2NvdW50LiBCdXQK
dGhhdCB3b3VsZCBsZWF2ZSBhIHJlZmVyZW5jZSB0byB0aGUgdGNwIHNlc3Npb24sIHdoZW4KaXQg
aGFzIGJlZW4gZnJlZWQgYWxyZWFkeS4KClNvIGdvaW5nIHdpdGggdGhlIGZvcm1lciBvcHRpb24g
YW5kIGNhbmNlbGxpbmcgdGhlCmRlbGF5ZWQgd29ya3MgZmlyc3QsIGJlZm9yZSByb2xsaW5nIGJh
Y2sgdGhlIGNoYW5uZWwuCgpGaXhlczogYWE0NWRhZGQzNGU0ICgiY2lmczogY2hhbmdlIGlmYWNl
X2xpc3QgZnJvbSBhcnJheSB0byBzb3J0ZWQgbGlua2VkIGxpc3QiKQpTaWduZWQtb2ZmLWJ5OiBT
aHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2
ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9zZXNzLmMgfCAx
MSArKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL3Nlc3MuYyBiL2ZzL2NpZnMvc2Vzcy5jCmluZGV4
IGI4NTcxOGYzMmI1My4uMDJjOGIyOTA2MTk2IDEwMDY0NAotLS0gYS9mcy9jaWZzL3Nlc3MuYwor
KysgYi9mcy9jaWZzL3Nlc3MuYwpAQCAtNDc0LDYgKzQ3NCwxNCBAQCBjaWZzX3Nlc19hZGRfY2hh
bm5lbChzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiLCBzdHJ1Y3QgY2lmc19zZXMgKnNlcywK
IAogb3V0OgogCWlmIChyYyAmJiBjaGFuLT5zZXJ2ZXIpIHsKKwkJLyoKKwkJICogd2Ugc2hvdWxk
IGF2b2lkIHJhY2Ugd2l0aCB0aGVzZSBkZWxheWVkIHdvcmtzIGJlZm9yZSB3ZQorCQkgKiByZW1v
dmUgdGhpcyBjaGFubmVsCisJCSAqLworCQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNoYW4t
PnNlcnZlci0+ZWNobyk7CisJCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmY2hhbi0+c2VydmVy
LT5yZXNvbHZlKTsKKwkJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjaGFuLT5zZXJ2ZXItPnJl
Y29ubmVjdCk7CisKIAkJc3Bpbl9sb2NrKCZzZXMtPmNoYW5fbG9jayk7CiAJCS8qIHdlIHJlbHkg
b24gYWxsIGJpdHMgYmV5b25kIGNoYW5fY291bnQgdG8gYmUgY2xlYXIgKi8KIAkJY2lmc19jaGFu
X2NsZWFyX25lZWRfcmVjb25uZWN0KHNlcywgY2hhbi0+c2VydmVyKTsKQEAgLTQ4NCwxMCArNDky
LDkgQEAgY2lmc19zZXNfYWRkX2NoYW5uZWwoc3RydWN0IGNpZnNfc2JfaW5mbyAqY2lmc19zYiwg
c3RydWN0IGNpZnNfc2VzICpzZXMsCiAJCSAqLwogCQlXQVJOX09OKHNlcy0+Y2hhbl9jb3VudCA8
IDEpOwogCQlzcGluX3VubG9jaygmc2VzLT5jaGFuX2xvY2spOwotCX0KIAotCWlmIChyYyAmJiBj
aGFuLT5zZXJ2ZXIpCiAJCWNpZnNfcHV0X3RjcF9zZXNzaW9uKGNoYW4tPnNlcnZlciwgMCk7CisJ
fQogCiAJcmV0dXJuIHJjOwogfQotLSAKMi4zNC4xCgo=
--00000000000095e97a05e31c721b--
