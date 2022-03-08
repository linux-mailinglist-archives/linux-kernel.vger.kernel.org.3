Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AC4D1CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348275AbiCHQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348235AbiCHQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:15:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C650E27
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:14:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n2so7987164plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=Xc8K+fIYQEF5ojV/e9F00uf2TYFgmauqDmzdG8mL/GU=;
        b=l8nKKt3rzvPdgwMd7JYzynNZCX1tIY0CldTD5v4zRPkxC9mAzuow31XwYJsiyt4VqQ
         hqSWSIjlrbenavSzgP/f094WPSACFS34RLW6skNyqKRcQO23v0aP/hfZxRtjky/Sy7cw
         et22qZmBZoGLXGXS/IB7hkzmDzIkpDQcyZS9fkPZ/c5qWTqneHPJ14+okckdBfPtSDvh
         8vo+rBo0ETbua8MhpwIgq/lEI7oOol7tSxLAGD6rfyj0mreVFC3dhrplIUnGdGvRSRY1
         dE+jhnzdraICIG++I8Rx6AOFJEtOwbT6Z1vo5PWwrj3UUnlw9UR0gYIiyYhFmvUd+ogo
         PFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=Xc8K+fIYQEF5ojV/e9F00uf2TYFgmauqDmzdG8mL/GU=;
        b=TxFv5nYS02AiIulQQGfqLU8tM/EG9qxrDpWI3ZAjSD0vnhduiLPh/WPGQl7zjlYu0+
         epZEexg42yYL9hcrET9L9MRrNCNIrzOS7klNSjS68Msqhy9hXwIaLmRQ3FG7nRUckeTL
         lL2iWJKYv5h7FyIGajCeysxW3R3jn5LYDaIACjlljwdoL8S8dWiHcxFv7DJwH0woASPU
         9sX7surHxiHTV1fsaqSiGDhrdSIkH8LBV7TxoD3ZamlCdlBMjI/VTIiX7m5KuoZ80mb/
         OTib91obcCYxV5PALvScqzaSeWgVzj47JoY2pONl90RjDul7V0IDSPMZpPU0EOUDCLDI
         vq3Q==
X-Gm-Message-State: AOAM533u4sranpiZc3vPrGcacZBSSBvsEAko9Nt414k0WU6shghp5wgD
        /qmzuc8j9Pz2MNFC2QPGncI=
X-Google-Smtp-Source: ABdhPJzPwTKQHInllkhzj/MYGeRCd5WxKfoohlfzMgeNtQmpT21vOJSMOzp1rqzqojnJNn/DHLvnKQ==
X-Received: by 2002:a17:902:f607:b0:14c:d9cf:a463 with SMTP id n7-20020a170902f60700b0014cd9cfa463mr18705890plg.32.1646756042361;
        Tue, 08 Mar 2022 08:14:02 -0800 (PST)
Received: from [192.168.122.100] (133-175-21-116.tokyo.ap.gmo-isp.jp. [133.175.21.116])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm21667150pfu.40.2022.03.08.08.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:14:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------XmOAkbK2J1lzVKUwLTmhagSz"
Message-ID: <510adc50-79aa-3ed2-ab6f-9f9711d9bb23@gmail.com>
Date:   Wed, 9 Mar 2022 01:13:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [BUG] mtd: cfi_cmdset_0002: write regression since v4.17-rc1
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, Joakim.Tjernlund@infinera.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com, richard@nod.at,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linuxppc-dev@lists.ozlabs.org
References: <b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de>
 <dff2abcc-5813-2f2c-35ba-f03cd1f35ac3@leemhuis.info>
 <e11b76dc-5539-fb7e-da1c-a5005713d6b0@gmail.com>
 <3dbbcee5-81fc-cdf5-9f8b-b6ccb95beddc@pengutronix.de>
 <0f2cfcac-83ca-51a9-f92c-ff6495dca1d7@gmail.com>
 <b231b498-c8d2-28af-ce66-db8c168047f7@pengutronix.de>
 <66ee55d9-4f20-6722-6097-e53c2108ea07@gmail.com>
 <579eab10-594c-d6b2-0ddb-ea6ab8e02856@pengutronix.de>
 <cedb1604-e024-2738-5b33-15703a653803@gmail.com>
 <117facba-ba33-349d-1085-25315cc1ae92@gmail.com>
 <f9e46b61-37e5-a280-edb0-27f8e81a8680@pengutronix.de>
 <9621c512-06f2-17b2-5c68-943b1f0981eb@gmail.com>
 <b23e4089-6431-de26-8666-bae4c3c8df88@pengutronix.de>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <b23e4089-6431-de26-8666-bae4c3c8df88@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------XmOAkbK2J1lzVKUwLTmhagSz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ahmad-san,

On 2022/03/08 18:44, Ahmad Fatoum wrote:
> Hello Tokunori,
>
> On 06.03.22 16:49, Tokunori Ikegami wrote:
>> Hi,
>>
>> On 2022/03/04 20:11, Ahmad Fatoum wrote:
>>> Hello Tokunori-san,
>>>
>>> On 20.02.22 13:22, Tokunori Ikegami wrote:
>>>> Hi Ahmad-san,
>>>>
>>>> Could you please try the version 2 patch attached for the error case?
>>>> This version is to check the DQ true data 0xFF by chip_good().
>>> I had a similar patch locally as well at first. I just tested yours
>>> and I can't reproduce the issue.
>> Thanks for your support.
>> Sorry if possible could you please retest the attached the patch again since this fixed the version 1 patch maintainer review comments?
> Works good.
>
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Thank you so much for your test.
>
>>>> But I am not sure if this works or not since the error is possible to be caused by Hi-Z 0xff on floating bus or etc.
>>> That it works for me could be because of Hi-Z 0xff, which is why
>>> decided against it.
>> I see.
>>>>>>>> What seems to work for me is checking if chip_good or chip_ready
>>>>>>>> and map_word is equal to 0xFF. I can't justify why this is ok though.
>>>>>>>> (Worst case bus is floating at this point of time and Hi-Z is read
>>>>>>>> as 0xff on CPU data lines...)
>>>>>>> Sorry I am not sure about this.
>>>>>>> I thought the chip_ready() itself is correct as implemented as the data sheet in the past.
>>>>>>> But it did not work correctly so changed to use chip_good() instead as it is also correct.
>>>>>> What exactly in the datasheet makes you believe chip_good is not appropriate?
>>>>> I just mentioned about the actual issue behaviors as not worked chip_good() on S29GL964N and not worked chip_ready() on MX29GL512FHT2I-11G before etc.
>>>>> Anyway let me recheck the data sheet details as just checked it again quickly but needed more investigation to understand.
>>>> As far as I checked still both chip_good() and chip_ready() seem correct but still the root cause is unknown.
>>>> If as you mentioned the issue was cased by the DQ true data 0xFF I am not sure why the read work without any error after the write operation.
>>>> Also if the error was caused by the Hi-Z 0xff on floating bus as mentioned I am not sure why the read work without any error after the write operation with chip_ready().
>>>> Sorry anyway the root cause is also unknown when the write operation was changed to use chip_good() instead of chip_ready().
>>> I've be ok with v1 then. Restores working behavior for me and shouldn't break others.
>> Noted but still I am thinking the version 2 patch to check 0xff seems better than to use chip_ready() so let me consider this again later.
> The original version has less room for surprise as it restores previously
> working behavior. Assuming 0xFF to be good without backing from documentation
> is more risky IMO.
The change to check 0xFF can be limited for the S29GL064N chip do you 
have any comment about this?
Just attached the patch changed as so and thinking to send the patch as 
version 3 to the maintainer if you are okay.

Regards,
Ikegami

>
> Thanks for your continued support,
> Ahmad
>
>> Regards,
>> Ikegami
>>
>>> Cheers and thanks again,
>>> Ahmad
>>>
>>>> Regards,
>>>> Ikegami
>>>>
>>>>> Regards,
>>>>> Ikegami
>>>>>
>>>>>> Cheers,
>>>>>> Ahmad
>>>>>>
>>>>>>
>
--------------XmOAkbK2J1lzVKUwLTmhagSz
Content-Type: text/plain; charset=UTF-8;
 name="v3-0001-mtd-cfi_cmdset_0002-Change-chip_good-to-check-DQ-.patch"
Content-Disposition: attachment;
 filename*0="v3-0001-mtd-cfi_cmdset_0002-Change-chip_good-to-check-DQ-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmNGU3NjdiNGM5YjJkNTEzOTM4NzE3NWYwYzU3YWZkODFmMGI2MmRlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUb2t1bm9yaSBJa2VnYW1pIDxpa2VnYW1pLnRAZ21h
aWwuY29tPgpEYXRlOiBTYXQsIDE5IEZlYiAyMDIyIDE5OjM5OjMyICswOTAwClN1YmplY3Q6
IFtQQVRDSCB2M10gbXRkOiBjZmlfY21kc2V0XzAwMDI6IENoYW5nZSBjaGlwX2dvb2QoKSB0
byBjaGVjayBEUSB0cnVlCiBkYXRhIDB4RkYgb24gUzI5R0wwNjROCgpUaGUgcmVncmVzc2lv
biBpc3N1ZSBoYXMgYmVlbiBjYXVzZWQgb24gUzI5R0wwNjROIGFuZCByZXBvcnRlZCBpdC4K
VGhlIGNoYW5nZSBtZW50aW9uZWQgZm9yIHJlZ3Jlc3Npb24gaXMgdG8gdXNlIGNoaXBfZ29v
ZCgpIGZvciBidWZmZXJlZCB3cml0ZS4KQWxzbyBpdCBzZWVtcyB0aGF0IHRoZSAweEZGIHZh
bHVlIGlzIHJlYWQgb24gdGhlIGVycm9yIGNhc2UuCkl0IGlzIHBvc3NpYmxlIHRvIGJlIGNh
dXNlZCBieSBEUSB0cnVlIGRhdGEgZGVzY3JpYmVkIGJ5IFMyOUdMMDY0TiBkYXRhc2hlZXQu
ClNvIGNoYW5nZSBjaGlwX2dvb2QoKSB0byBjaGVjayBEUSB0cnVlIGRhdGEgMHhGRiBhZGRp
dGlvbmFsbHkgZm9yIHRoZSBlcnJvci4KCkZpeGVzOiBkZmVhZTEwNzM1ODMoIm10ZDogY2Zp
X2NtZHNldF8wMDAyOiBDaGFuZ2Ugd3JpdGUgYnVmZmVyIHRvIGNoZWNrIGNvcnJlY3QgdmFs
dWUiKQpTaWduZWQtb2ZmLWJ5OiBUb2t1bm9yaSBJa2VnYW1pIDxpa2VnYW1pLnRAZ21haWwu
Y29tPgpDYzogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KQ2M6
IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CkNjOiBWaWduZXNoIFJhZ2hh
dmVuZHJhIDx2aWduZXNockB0aS5jb20+CkNjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpMaW5rOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yL2I2ODdjMjU5LTY0MTMtMjZjOS1kNGM5LWIzYWZhNjllYTEyNEBwZW5ndXRy
b25peC5kZS8KLS0tCiBkcml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIuYyB8IDM2
ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQv
Y2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMgYi9kcml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0
XzAwMDIuYwppbmRleCBhNzYxMTM0ZmQzYmUuLjk5YzFjNjc0MWI2OSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMKKysrIGIvZHJpdmVycy9tdGQv
Y2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMKQEAgLTQ4LDYgKzQ4LDcgQEAKICNkZWZpbmUgU1NU
NDlMRjA0MEIJCTB4MDA1MAogI2RlZmluZSBTU1Q0OUxGMDA4QQkJMHgwMDVhCiAjZGVmaW5l
IEFUNDlCVjY0MTYJCTB4MDBkNgorI2RlZmluZSBTMjlHTDA2NE5fTU4xMgkJMHgwYzAxCiAK
IC8qCiAgKiBTdGF0dXMgUmVnaXN0ZXIgYml0IGRlc2NyaXB0aW9uLiBVc2VkIGJ5IGZsYXNo
IGRldmljZXMgdGhhdCBkb24ndApAQCAtNDYyLDcgKzQ2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
Y2ZpX2ZpeHVwIGNmaV9maXh1cF90YWJsZVtdID0gewogCXsgQ0ZJX01GUl9BTUQsIDB4MDA1
NiwgZml4dXBfdXNlX3NlY3NpIH0sCiAJeyBDRklfTUZSX0FNRCwgMHgwMDVDLCBmaXh1cF91
c2Vfc2Vjc2kgfSwKIAl7IENGSV9NRlJfQU1ELCAweDAwNUYsIGZpeHVwX3VzZV9zZWNzaSB9
LAotCXsgQ0ZJX01GUl9BTUQsIDB4MGMwMSwgZml4dXBfczI5Z2wwNjRuX3NlY3RvcnMgfSwK
Kwl7IENGSV9NRlJfQU1ELCBTMjlHTDA2NE5fTU4xMiwgZml4dXBfczI5Z2wwNjRuX3NlY3Rv
cnMgfSwKIAl7IENGSV9NRlJfQU1ELCAweDEzMDEsIGZpeHVwX3MyOWdsMDY0bl9zZWN0b3Jz
IH0sCiAJeyBDRklfTUZSX0FNRCwgMHgxYTAwLCBmaXh1cF9zMjlnbDAzMm5fc2VjdG9ycyB9
LAogCXsgQ0ZJX01GUl9BTUQsIDB4MWEwMSwgZml4dXBfczI5Z2wwMzJuX3NlY3RvcnMgfSwK
QEAgLTgzNyw2ICs4MzgsMTEgQEAgc3RhdGljIGludCBfX3hpcHJhbSBjaGlwX3JlYWR5KHN0
cnVjdCBtYXBfaW5mbyAqbWFwLCBzdHJ1Y3QgZmxjaGlwICpjaGlwLAogCXJldHVybiBtYXBf
d29yZF9lcXVhbChtYXAsIGQsIHQpOwogfQogCitzdGF0aWMgYm9vbCBfX3hpcHJhbSBjZmlf
dXNlX2RxX3RydWVfZGF0YShzdHJ1Y3QgY2ZpX3ByaXZhdGUgKmNmaSkKK3sKKwlyZXR1cm4g
Y2ZpLT5tZnIgPT0gQ0ZJX01GUl9BTUQgJiYgY2ZpLT5pZCA9PSBTMjlHTDA2NE5fTU4xMjsK
K30KKwogLyoKICAqIFJldHVybiB0cnVlIGlmIHRoZSBjaGlwIGlzIHJlYWR5IGFuZCBoYXMg
dGhlIGNvcnJlY3QgdmFsdWUuCiAgKgpAQCAtODUzLDcgKzg1OSw3IEBAIHN0YXRpYyBpbnQg
X194aXByYW0gY2hpcF9yZWFkeShzdHJ1Y3QgbWFwX2luZm8gKm1hcCwgc3RydWN0IGZsY2hp
cCAqY2hpcCwKICAqCiAgKi8KIHN0YXRpYyBpbnQgX194aXByYW0gY2hpcF9nb29kKHN0cnVj
dCBtYXBfaW5mbyAqbWFwLCBzdHJ1Y3QgZmxjaGlwICpjaGlwLAotCQkJICAgICAgdW5zaWdu
ZWQgbG9uZyBhZGRyLCBtYXBfd29yZCBleHBlY3RlZCkKKwkJCSAgICAgIHVuc2lnbmVkIGxv
bmcgYWRkciwgbWFwX3dvcmQgKmV4cGVjdGVkKQogewogCXN0cnVjdCBjZmlfcHJpdmF0ZSAq
Y2ZpID0gbWFwLT5mbGRydl9wcml2OwogCW1hcF93b3JkIG9sZGQsIGN1cmQ7CkBAIC04NzUs
OCArODgxLDE2IEBAIHN0YXRpYyBpbnQgX194aXByYW0gY2hpcF9nb29kKHN0cnVjdCBtYXBf
aW5mbyAqbWFwLCBzdHJ1Y3QgZmxjaGlwICpjaGlwLAogCW9sZGQgPSBtYXBfcmVhZChtYXAs
IGFkZHIpOwogCWN1cmQgPSBtYXBfcmVhZChtYXAsIGFkZHIpOwogCi0JcmV0dXJuCW1hcF93
b3JkX2VxdWFsKG1hcCwgb2xkZCwgY3VyZCkgJiYKLQkJbWFwX3dvcmRfZXF1YWwobWFwLCBj
dXJkLCBleHBlY3RlZCk7CisJaWYgKCFtYXBfd29yZF9lcXVhbChtYXAsIG9sZGQsIGN1cmQp
KQorCQlyZXR1cm4gMDsKKworCWlmIChleHBlY3RlZCAmJiBtYXBfd29yZF9lcXVhbChtYXAs
IGN1cmQsICpleHBlY3RlZCkpCisJCXJldHVybiAxOworCisJaWYgKGNmaV91c2VfZHFfdHJ1
ZV9kYXRhKGNmaSkpCisJCXJldHVybiBtYXBfd29yZF9lcXVhbChtYXAsIG9sZGQsIG1hcF93
b3JkX2ZmKG1hcCkpOworCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgZ2V0X2NoaXAo
c3RydWN0IG1hcF9pbmZvICptYXAsIHN0cnVjdCBmbGNoaXAgKmNoaXAsIHVuc2lnbmVkIGxv
bmcgYWRyLCBpbnQgbW9kZSkKQEAgLTE2OTksNyArMTcxMyw3IEBAIHN0YXRpYyBpbnQgX194
aXByYW0gZG9fd3JpdGVfb25ld29yZF9vbmNlKHN0cnVjdCBtYXBfaW5mbyAqbWFwLAogCQkg
KiAiY2hpcF9nb29kIiB0byBhdm9pZCB0aGUgZmFpbHVyZSBkdWUgdG8gc2NoZWR1bGluZy4K
IAkJICovCiAJCWlmICh0aW1lX2FmdGVyKGppZmZpZXMsIHRpbWVvKSAmJgotCQkgICAgIWNo
aXBfZ29vZChtYXAsIGNoaXAsIGFkciwgZGF0dW0pKSB7CisJCSAgICAhY2hpcF9nb29kKG1h
cCwgY2hpcCwgYWRyLCAmZGF0dW0pKSB7CiAJCQl4aXBfZW5hYmxlKG1hcCwgY2hpcCwgYWRy
KTsKIAkJCXByaW50ayhLRVJOX1dBUk5JTkcgIk1URCAlcygpOiBzb2Z0d2FyZSB0aW1lb3V0
XG4iLCBfX2Z1bmNfXyk7CiAJCQl4aXBfZGlzYWJsZShtYXAsIGNoaXAsIGFkcik7CkBAIC0x
NzA3LDcgKzE3MjEsNyBAQCBzdGF0aWMgaW50IF9feGlwcmFtIGRvX3dyaXRlX29uZXdvcmRf
b25jZShzdHJ1Y3QgbWFwX2luZm8gKm1hcCwKIAkJCWJyZWFrOwogCQl9CiAKLQkJaWYgKGNo
aXBfZ29vZChtYXAsIGNoaXAsIGFkciwgZGF0dW0pKSB7CisJCWlmIChjaGlwX2dvb2QobWFw
LCBjaGlwLCBhZHIsICZkYXR1bSkpIHsKIAkJCWlmIChjZmlfY2hlY2tfZXJyX3N0YXR1cyht
YXAsIGNoaXAsIGFkcikpCiAJCQkJcmV0ID0gLUVJTzsKIAkJCWJyZWFrOwpAQCAtMTk3OSwx
NCArMTk5MywxNCBAQCBzdGF0aWMgaW50IF9feGlwcmFtIGRvX3dyaXRlX2J1ZmZlcl93YWl0
KHN0cnVjdCBtYXBfaW5mbyAqbWFwLAogCQkgKiAiY2hpcF9nb29kIiB0byBhdm9pZCB0aGUg
ZmFpbHVyZSBkdWUgdG8gc2NoZWR1bGluZy4KIAkJICovCiAJCWlmICh0aW1lX2FmdGVyKGpp
ZmZpZXMsIHRpbWVvKSAmJgotCQkgICAgIWNoaXBfZ29vZChtYXAsIGNoaXAsIGFkciwgZGF0
dW0pKSB7CisJCSAgICAhY2hpcF9nb29kKG1hcCwgY2hpcCwgYWRyLCAmZGF0dW0pKSB7CiAJ
CQlwcl9lcnIoIk1URCAlcygpOiBzb2Z0d2FyZSB0aW1lb3V0LCBhZGRyZXNzOjB4JS44bHgu
XG4iLAogCQkJICAgICAgIF9fZnVuY19fLCBhZHIpOwogCQkJcmV0ID0gLUVJTzsKIAkJCWJy
ZWFrOwogCQl9CiAKLQkJaWYgKGNoaXBfZ29vZChtYXAsIGNoaXAsIGFkciwgZGF0dW0pKSB7
CisJCWlmIChjaGlwX2dvb2QobWFwLCBjaGlwLCBhZHIsICZkYXR1bSkpIHsKIAkJCWlmIChj
ZmlfY2hlY2tfZXJyX3N0YXR1cyhtYXAsIGNoaXAsIGFkcikpCiAJCQkJcmV0ID0gLUVJTzsK
IAkJCWJyZWFrOwpAQCAtMjI4Miw3ICsyMjk2LDcgQEAgc3RhdGljIGludCBkb19wYW5pY193
cml0ZV9vbmV3b3JkKHN0cnVjdCBtYXBfaW5mbyAqbWFwLCBzdHJ1Y3QgZmxjaGlwICpjaGlw
LAogCQl1ZGVsYXkoMSk7CiAJfQogCi0JaWYgKCFjaGlwX2dvb2QobWFwLCBjaGlwLCBhZHIs
IGRhdHVtKSB8fAorCWlmICghY2hpcF9nb29kKG1hcCwgY2hpcCwgYWRyLCAmZGF0dW0pIHx8
CiAJICAgIGNmaV9jaGVja19lcnJfc3RhdHVzKG1hcCwgY2hpcCwgYWRyKSkgewogCQkvKiBy
ZXNldCBvbiBhbGwgZmFpbHVyZXMuICovCiAJCW1hcF93cml0ZShtYXAsIENNRCgweEYwKSwg
Y2hpcC0+c3RhcnQpOwpAQCAtMjQ3OCw3ICsyNDkyLDcgQEAgc3RhdGljIGludCBfX3hpcHJh
bSBkb19lcmFzZV9jaGlwKHN0cnVjdCBtYXBfaW5mbyAqbWFwLCBzdHJ1Y3QgZmxjaGlwICpj
aGlwKQogCQkJY2hpcC0+ZXJhc2Vfc3VzcGVuZGVkID0gMDsKIAkJfQogCi0JCWlmIChjaGlw
X2dvb2QobWFwLCBjaGlwLCBhZHIsIG1hcF93b3JkX2ZmKG1hcCkpKSB7CisJCWlmIChjaGlw
X2dvb2QobWFwLCBjaGlwLCBhZHIsIE5VTEwpKSB7CiAJCQlpZiAoY2ZpX2NoZWNrX2Vycl9z
dGF0dXMobWFwLCBjaGlwLCBhZHIpKQogCQkJCXJldCA9IC1FSU87CiAJCQlicmVhazsKQEAg
LTI1NzcsNyArMjU5MSw3IEBAIHN0YXRpYyBpbnQgX194aXByYW0gZG9fZXJhc2Vfb25lYmxv
Y2soc3RydWN0IG1hcF9pbmZvICptYXAsIHN0cnVjdCBmbGNoaXAgKmNoaXAsCiAJCQljaGlw
LT5lcmFzZV9zdXNwZW5kZWQgPSAwOwogCQl9CiAKLQkJaWYgKGNoaXBfZ29vZChtYXAsIGNo
aXAsIGFkciwgbWFwX3dvcmRfZmYobWFwKSkpIHsKKwkJaWYgKGNoaXBfZ29vZChtYXAsIGNo
aXAsIGFkciwgTlVMTCkpIHsKIAkJCWlmIChjZmlfY2hlY2tfZXJyX3N0YXR1cyhtYXAsIGNo
aXAsIGFkcikpCiAJCQkJcmV0ID0gLUVJTzsKIAkJCWJyZWFrOwotLSAKMi4zMi4wCgo=

--------------XmOAkbK2J1lzVKUwLTmhagSz--
