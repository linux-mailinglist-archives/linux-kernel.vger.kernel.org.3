Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1D52DEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiESVCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244973AbiESVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:02:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22955B8BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:02:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e194so6981472iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to;
        bh=J45nxiIginhts6Jm0kOSgIiDpYcSC9v2HbBp5Gto/wM=;
        b=hDtMVVAkQQ+KkmmUfZRymqe27XAM7gmW4k9yTZH28A1+5apENo16e+T3ibOlzNgakj
         SwjXeySTSjqRku/EEWyoFJR4uVq5dFn9UT62SdGsUjqpGGj4TiIgrr902MYB0NlJHI3J
         ha3rinPMsH1qNf2wGI+uUWJVWC9iyQOQhYg0g72EjIr4uALroiACFH0fK9Q1vSLUOCJL
         coQaiPQBDO6EZn0aYE/+0yvZUlUAazhnFCSjd8Da65meDhJnPiaXKTu2CAVP99HfmIaH
         vLPJZsGcmAen8UjrydFIXOMTicsADZE1I9fDyyO6iupQu3jLwVZTFYayg+/SwMjhEB84
         fZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to;
        bh=J45nxiIginhts6Jm0kOSgIiDpYcSC9v2HbBp5Gto/wM=;
        b=ciXM4w1KBQGKaXpCYIcdNNz1wsZ1pPljpmCRVu4kCgDGMWupj2ujc8ZXvPiCskhdLX
         x5BKCQAgyFd9QjS9zY0HW5I4ron1J5dCAYT6lX6m4lbRy5vkhOkFDnq/LkORUl2dQPdt
         x2jghgm1fVi6/6uzEmgQ+bXzrvb1nQ+bbrCoi1JbErEatQ7v9zVOZnqpb86EB2P3e8ZC
         9Ssmm+mD6N+olqjQrrkgUt5GZChptmJRGlVs+DNIE6Ltljkt0SSGVdJVe8db9m2SCvSg
         t8jNfFCZU/vo4SyrXJjoQmAj7dU/Zk711Ts4eG5fhEyQBKUAThg2Fi+oMGZp02TeSriv
         i0BQ==
X-Gm-Message-State: AOAM5312tRm+18+f12efbU+D1gWb9gb6TJpOExUMVSDBRGylA1u5dIrH
        c6P9YiVowuSQ/7SzGvgNaM214Q==
X-Google-Smtp-Source: ABdhPJwsEoNfZQCFGpTpwxUyGoA2qzIYU5J+AnHhx9xHq5HQ/cXiuqI2NH848uUkGcTpFIfmg83Cjg==
X-Received: by 2002:a05:6638:2042:b0:32b:c513:21b2 with SMTP id t2-20020a056638204200b0032bc51321b2mr3647023jaj.90.1652994150073;
        Thu, 19 May 2022 14:02:30 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o1-20020a02cc21000000b0032b74686763sm179325jap.76.2022.05.19.14.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 14:02:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------P5A0T3KEH2VrqjzGPg8PEPKc"
Message-ID: <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk>
Date:   Thu, 19 May 2022 15:02:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com> <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
In-Reply-To: <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------P5A0T3KEH2VrqjzGPg8PEPKc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/22 2:49 PM, Jens Axboe wrote:
> On 5/19/22 2:05 PM, Jason A. Donenfeld wrote:
>> Hi Jens,
>>
>> On Thu, May 19, 2022 at 01:31:31PM -0600, Jens Axboe wrote:
>>> Hi,
>>>
>>> We recently had a failure on a kernel upgrade because splice no longer
>>> works on random/urandom. This is due to:
>>>
>>> 6e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
>>
>> Thanks for this. I'd noticed this a few months ago and assumed it has
>> just always been that way, and hadn't gotten to looking at what was up.
>>
>> I'll take a look at these patches in detail when I'm home in a few
>> hours, but one thing maybe you can answer more easily than my digging
>> is:
> 
> Sounds good, thanks!
> 
>> There's a lot of attention in random.c devoted to not leaving any output
>> around on the stack or in stray buffers. The explicit use of
>> copy_to_user() makes it clear that the output isn't being copied
>> anywhere other than what's the user's responsibility to cleanup. I'm
>> wondering if the switch to copy_to_iter() introduces any buffering or
>> gotchas that you might be aware of.
> 
> No, it's just a wrapper around copying to the user memory pointed to by
> the iov_iter. No extra buffering or anything like that. So I think it
> should be fine in that respect, and it actually cleans up the code a bit
> imho since the copy_to_iter() since the return value of "bytes copied"
> is easier to work with than the "bytes not copied".
> 
>> Also you may need to rebase this on the random.git tree at
>> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
> 
> OK, I will rebase it on that branch, not a problem.

Rebased patches attached, you can also find them here:

https://git.kernel.dk/cgit/linux-block/log/?h=random-splice

Did some basic sanity checking (and with splice too), and seems fine
rebased as well.

-- 
Jens Axboe

--------------P5A0T3KEH2VrqjzGPg8PEPKc
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-random-wire-up-fops-splice_read_iter.patch"
Content-Disposition: attachment;
 filename="0002-random-wire-up-fops-splice_read_iter.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZDY3M2RhYzlmN2M5MDVkOTVjYmUzMzRjYzc1MTlmYjM2ZWRlNjc4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTkgTWF5IDIwMjIgMTM6MjY6NTUgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gcmFuZG9tOiB3aXJlIHVwIGZvcHMtPnNwbGljZV9yZWFkX2l0ZXIoKQoKTm93IHRoYXQg
cmFuZG9tL3VyYW5kb20gaXMgdXNpbmcgcmVhZF9pdGVyLCB3ZSBjYW4gd2lyZSBpdCB1cCB0
byB1c2luZwp0aGUgZ2VuZXJpYyBzcGxpY2UgcmVhZCBoYW5kbGVyLgoKRml4ZXM6IDM2ZTJj
NzQyMWYwMiAoImZzOiBkb24ndCBhbGxvdyBzcGxpY2UgcmVhZC93cml0ZSB3aXRob3V0IGV4
cGxpY2l0IG9wcyIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4KLS0tCiBkcml2ZXJzL2NoYXIvcmFuZG9tLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3JhbmRvbS5jIGIv
ZHJpdmVycy9jaGFyL3JhbmRvbS5jCmluZGV4IDE0NzkyMWQ0NzFkOC4uODkyNTEzZmI3NDc5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMKKysrIGIvZHJpdmVycy9jaGFy
L3JhbmRvbS5jCkBAIC0xNDE1LDYgKzE0MTUsNyBAQCBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVy
YXRpb25zIHJhbmRvbV9mb3BzID0gewogCS5jb21wYXRfaW9jdGwgPSBjb21wYXRfcHRyX2lv
Y3RsLAogCS5mYXN5bmMgPSByYW5kb21fZmFzeW5jLAogCS5sbHNlZWsgPSBub29wX2xsc2Vl
aywKKwkuc3BsaWNlX3JlYWQgPSBnZW5lcmljX2ZpbGVfc3BsaWNlX3JlYWQsCiB9OwogCiBj
b25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHVyYW5kb21fZm9wcyA9IHsKQEAgLTE0MjQs
NiArMTQyNSw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgdXJhbmRvbV9mb3Bz
ID0gewogCS5jb21wYXRfaW9jdGwgPSBjb21wYXRfcHRyX2lvY3RsLAogCS5mYXN5bmMgPSBy
YW5kb21fZmFzeW5jLAogCS5sbHNlZWsgPSBub29wX2xsc2VlaywKKwkuc3BsaWNlX3JlYWQg
PSBnZW5lcmljX2ZpbGVfc3BsaWNlX3JlYWQsCiB9OwogCiAKLS0gCjIuMzUuMQoK
--------------P5A0T3KEH2VrqjzGPg8PEPKc
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-random-convert-to-using-fops-read_iter.patch"
Content-Disposition: attachment;
 filename="0001-random-convert-to-using-fops-read_iter.patch"
Content-Transfer-Encoding: base64

RnJvbSBjNjVmMDIyMWI3MjE3M2MxOTM5ODg4NGYzZjQ5ZWY3NzVlMmM2NjhmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTkgTWF5IDIwMjIgMTQ6NTU6MzcgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gcmFuZG9tOiBjb252ZXJ0IHRvIHVzaW5nIGZvcHMtPnJlYWRfaXRlcigpCgpUaGlzIGlz
IGEgcHJlLXJlcXVpc2l0ZSB0byB3cml0aW5nIHVwIHNwbGljZSgpIGFnYWluIGZvciB0aGUg
cmFuZG9tCmFuZCB1cmFuZG9tIGRyaXZlcnMuCgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogZHJpdmVycy9jaGFyL3JhbmRvbS5jIHwgMzkgKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jaGFyL3JhbmRvbS5jIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5jCmluZGV4IDA5NThmYTkx
YTk2NC4uMTQ3OTIxZDQ3MWQ4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMK
KysrIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5jCkBAIC0zOTcsMTEgKzM5NywxMiBAQCB2b2lk
IGdldF9yYW5kb21fYnl0ZXModm9pZCAqYnVmLCBzaXplX3QgbGVuKQogfQogRVhQT1JUX1NZ
TUJPTChnZXRfcmFuZG9tX2J5dGVzKTsKIAotc3RhdGljIHNzaXplX3QgZ2V0X3JhbmRvbV9i
eXRlc191c2VyKHZvaWQgX191c2VyICp1YnVmLCBzaXplX3QgbGVuKQorc3RhdGljIHNzaXpl
X3QgZ2V0X3JhbmRvbV9ieXRlc191c2VyKHN0cnVjdCBpb3ZfaXRlciAqdG8pCiB7Ci0Jc2l6
ZV90IGJsb2NrX2xlbiwgbGVmdCwgcmV0ID0gMDsKKwlzaXplX3QgYmxvY2tfbGVuLCByZXQg
PSAwOwogCXUzMiBjaGFjaGFfc3RhdGVbQ0hBQ0hBX1NUQVRFX1dPUkRTXTsKIAl1OCBvdXRw
dXRbQ0hBQ0hBX0JMT0NLX1NJWkVdOworCXNpemVfdCBsZW4gPSBpb3ZfaXRlcl9jb3VudCh0
byk7CiAKIAlpZiAoIWxlbikKIAkJcmV0dXJuIDA7CkBAIC00MTgsNyArNDE5LDcgQEAgc3Rh
dGljIHNzaXplX3QgZ2V0X3JhbmRvbV9ieXRlc191c2VyKHZvaWQgX191c2VyICp1YnVmLCBz
aXplX3QgbGVuKQogCSAqIHRoZSB1c2VyIGRpcmVjdGx5LgogCSAqLwogCWlmIChsZW4gPD0g
Q0hBQ0hBX0tFWV9TSVpFKSB7Ci0JCXJldCA9IGxlbiAtIGNvcHlfdG9fdXNlcih1YnVmLCAm
Y2hhY2hhX3N0YXRlWzRdLCBsZW4pOworCQlyZXQgPSBjb3B5X3RvX2l0ZXIoJmNoYWNoYV9z
dGF0ZVs0XSwgbGVuLCB0byk7CiAJCWdvdG8gb3V0X3plcm9fY2hhY2hhOwogCX0KIApAQCAt
NDI4LDE3ICs0MjksMTIgQEAgc3RhdGljIHNzaXplX3QgZ2V0X3JhbmRvbV9ieXRlc191c2Vy
KHZvaWQgX191c2VyICp1YnVmLCBzaXplX3QgbGVuKQogCQkJKytjaGFjaGFfc3RhdGVbMTNd
OwogCiAJCWJsb2NrX2xlbiA9IG1pbl90KHNpemVfdCwgbGVuLCBDSEFDSEFfQkxPQ0tfU0la
RSk7Ci0JCWxlZnQgPSBjb3B5X3RvX3VzZXIodWJ1Ziwgb3V0cHV0LCBibG9ja19sZW4pOwot
CQlpZiAobGVmdCkgewotCQkJcmV0ICs9IGJsb2NrX2xlbiAtIGxlZnQ7CisJCWJsb2NrX2xl
biA9IGNvcHlfdG9faXRlcihvdXRwdXQsIGJsb2NrX2xlbiwgdG8pOworCQlpZiAoIWJsb2Nr
X2xlbikKIAkJCWJyZWFrOwotCQl9CiAKLQkJdWJ1ZiArPSBibG9ja19sZW47CiAJCXJldCAr
PSBibG9ja19sZW47CiAJCWxlbiAtPSBibG9ja19sZW47Ci0JCWlmICghbGVuKQotCQkJYnJl
YWs7CiAKIAkJQlVJTERfQlVHX09OKFBBR0VfU0laRSAlIENIQUNIQV9CTE9DS19TSVpFICE9
IDApOwogCQlpZiAocmV0ICUgUEFHRV9TSVpFID09IDApIHsKQEAgLTEyNDgsNiArMTI0NCw5
IEBAIHN0YXRpYyB2b2lkIF9fY29sZCB0cnlfdG9fZ2VuZXJhdGVfZW50cm9weSh2b2lkKQog
CiBTWVNDQUxMX0RFRklORTMoZ2V0cmFuZG9tLCBjaGFyIF9fdXNlciAqLCB1YnVmLCBzaXpl
X3QsIGxlbiwgdW5zaWduZWQgaW50LCBmbGFncykKIHsKKwlzdHJ1Y3QgaW92ZWMgaW92ID0g
eyAuaW92X2Jhc2UgPSB1YnVmIH07CisJc3RydWN0IGlvdl9pdGVyIGl0ZXI7CisKIAlpZiAo
ZmxhZ3MgJiB+KEdSTkRfTk9OQkxPQ0sgfCBHUk5EX1JBTkRPTSB8IEdSTkRfSU5TRUNVUkUp
KQogCQlyZXR1cm4gLUVJTlZBTDsKIApAQCAtMTI3MCw3ICsxMjY5LDkgQEAgU1lTQ0FMTF9E
RUZJTkUzKGdldHJhbmRvbSwgY2hhciBfX3VzZXIgKiwgdWJ1Ziwgc2l6ZV90LCBsZW4sIHVu
c2lnbmVkIGludCwgZmxhZ3MKIAkJaWYgKHVubGlrZWx5KHJldCkpCiAJCQlyZXR1cm4gcmV0
OwogCX0KLQlyZXR1cm4gZ2V0X3JhbmRvbV9ieXRlc191c2VyKHVidWYsIGxlbik7CisJaW92
Lmlvdl9sZW4gPSBsZW47CisJaW92X2l0ZXJfaW5pdCgmaXRlciwgUkVBRCwgJmlvdiwgMSwg
bGVuKTsKKwlyZXR1cm4gZ2V0X3JhbmRvbV9ieXRlc191c2VyKCZpdGVyKTsKIH0KIAogc3Rh
dGljIF9fcG9sbF90IHJhbmRvbV9wb2xsKHN0cnVjdCBmaWxlICpmaWxlLCBwb2xsX3RhYmxl
ICp3YWl0KQpAQCAtMTMxNCw4ICsxMzE1LDcgQEAgc3RhdGljIHNzaXplX3QgcmFuZG9tX3dy
aXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqdWJ1ZiwKIAlyZXR1
cm4gKHNzaXplX3QpbGVuOwogfQogCi1zdGF0aWMgc3NpemVfdCB1cmFuZG9tX3JlYWQoc3Ry
dWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICp1YnVmLAotCQkJICAgIHNpemVfdCBsZW4s
IGxvZmZfdCAqcHBvcykKK3N0YXRpYyBzc2l6ZV90IHVyYW5kb21fcmVhZF9pdGVyKHN0cnVj
dCBraW9jYiAqa2lvY2IsIHN0cnVjdCBpb3ZfaXRlciAqdG8pCiB7CiAJc3RhdGljIGludCBt
YXh3YXJuID0gMTA7CiAKQEAgLTEzMzIsMjIgKzEzMzIsMjEgQEAgc3RhdGljIHNzaXplX3Qg
dXJhbmRvbV9yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIF9fdXNlciAqdWJ1ZiwKIAkJ
ZWxzZSBpZiAocmF0ZWxpbWl0X2Rpc2FibGUgfHwgX19yYXRlbGltaXQoJnVyYW5kb21fd2Fy
bmluZykpIHsKIAkJCS0tbWF4d2FybjsKIAkJCXByX25vdGljZSgiJXM6IHVuaW5pdGlhbGl6
ZWQgdXJhbmRvbSByZWFkICglemQgYnl0ZXMgcmVhZClcbiIsCi0JCQkJICBjdXJyZW50LT5j
b21tLCBsZW4pOworCQkJCSAgY3VycmVudC0+Y29tbSwgaW92X2l0ZXJfY291bnQodG8pKTsK
IAkJfQogCX0KIAotCXJldHVybiBnZXRfcmFuZG9tX2J5dGVzX3VzZXIodWJ1ZiwgbGVuKTsK
KwlyZXR1cm4gZ2V0X3JhbmRvbV9ieXRlc191c2VyKHRvKTsKIH0KIAotc3RhdGljIHNzaXpl
X3QgcmFuZG9tX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICp1YnVmLAot
CQkJICAgc2l6ZV90IGxlbiwgbG9mZl90ICpwcG9zKQorc3RhdGljIHNzaXplX3QgcmFuZG9t
X3JlYWRfaXRlcihzdHJ1Y3Qga2lvY2IgKmtpb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKnRvKQog
ewogCWludCByZXQ7CiAKIAlyZXQgPSB3YWl0X2Zvcl9yYW5kb21fYnl0ZXMoKTsKIAlpZiAo
cmV0ICE9IDApCiAJCXJldHVybiByZXQ7Ci0JcmV0dXJuIGdldF9yYW5kb21fYnl0ZXNfdXNl
cih1YnVmLCBsZW4pOworCXJldHVybiBnZXRfcmFuZG9tX2J5dGVzX3VzZXIodG8pOwogfQog
CiBzdGF0aWMgbG9uZyByYW5kb21faW9jdGwoc3RydWN0IGZpbGUgKmYsIHVuc2lnbmVkIGlu
dCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKQpAQCAtMTQwOSw3ICsxNDA4LDcgQEAgc3RhdGlj
IGludCByYW5kb21fZmFzeW5jKGludCBmZCwgc3RydWN0IGZpbGUgKmZpbHAsIGludCBvbikK
IH0KIAogY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyByYW5kb21fZm9wcyA9IHsKLQku
cmVhZCA9IHJhbmRvbV9yZWFkLAorCS5yZWFkX2l0ZXIgPSByYW5kb21fcmVhZF9pdGVyLAog
CS53cml0ZSA9IHJhbmRvbV93cml0ZSwKIAkucG9sbCA9IHJhbmRvbV9wb2xsLAogCS51bmxv
Y2tlZF9pb2N0bCA9IHJhbmRvbV9pb2N0bCwKQEAgLTE0MTksNyArMTQxOCw3IEBAIGNvbnN0
IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgcmFuZG9tX2ZvcHMgPSB7CiB9OwogCiBjb25zdCBz
dHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHVyYW5kb21fZm9wcyA9IHsKLQkucmVhZCA9IHVyYW5k
b21fcmVhZCwKKwkucmVhZF9pdGVyID0gdXJhbmRvbV9yZWFkX2l0ZXIsCiAJLndyaXRlID0g
cmFuZG9tX3dyaXRlLAogCS51bmxvY2tlZF9pb2N0bCA9IHJhbmRvbV9pb2N0bCwKIAkuY29t
cGF0X2lvY3RsID0gY29tcGF0X3B0cl9pb2N0bCwKLS0gCjIuMzUuMQoK

--------------P5A0T3KEH2VrqjzGPg8PEPKc--
