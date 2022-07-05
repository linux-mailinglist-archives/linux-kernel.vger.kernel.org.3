Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9E56639D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiGEHEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGEHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:03:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9892512D07;
        Tue,  5 Jul 2022 00:03:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y18so2241279plb.2;
        Tue, 05 Jul 2022 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=2ufLS6mmfGLjwF9pxsw1TQp1kLjrOVbI80R+vNoRSvk=;
        b=PX8gc5mIejixPJCgPu0KBUXlOXb+wzKfs6yxAOjWuKajPAVu/Uo8igsaQ4uYjFaAoE
         2OhpLmyfX7k7gQH2/vPnqc2KB0DVcSUqan3DGUMpiJjvrs84XVLn/XN42fMcrtMZqTIB
         3MrsFxvUcpskmMJdOVZmdYavsFRvchrpwk1ENUuorkOlwk2/FwKrOXZeoXkEO9t1xShE
         qvX148aymfVztwC65QfoPFkSsK4vDLU1nlJpgYn8DuU2SbU2pRItVhCKmGPmQuhtDrFU
         A7luZn0sxeWf262qZiu9Ywb0zmRaBZYpEVjF5Q9W+jSDg2hIQ2ybgvDNH24lpvX3rIdG
         2R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=2ufLS6mmfGLjwF9pxsw1TQp1kLjrOVbI80R+vNoRSvk=;
        b=50RRAnnDyIuD4u8UGfkrNUiRNYAvsYbL8eWItpy/Q88FwsFFkJXKt6TtWVLR5XEP19
         XDflcRhWSCvZ1S19Tbgx3Sogf8pvQps4m8iyO6rd+w2Y1x2fMP0FuMTEi6tRp4cpc7Dr
         V7eNEL+ecLtjoL0nRUm6TGeXE0idz5uXkk+xhuzciLaos5sVklaIxsaqhH4fLRTNdBq2
         6hB1oDYsfNP8WXKxJkbY4UqfvBWqlDvDuoskQxaRvoRB+P+6lbcxaSDhrtVdw9SEUqKh
         /3OZIQ7jpMF+GDj+xmMlqv3Z6kK6XS9JXuxNFFMS0RfdReT1+D+x4i83o/j3WyZ2K5RD
         fszw==
X-Gm-Message-State: AJIora+qVVv7JzyD5S1Q/lnERj/Soi+340NPtQPX7rBHRKBEq4s340RE
        eNzgijAoUFDXlQqTTHMGm+k=
X-Google-Smtp-Source: AGRyM1vmviWyx2o7pqRKS6HpNTGuLHcvSoMidTGwEgDcYRIXJPxrH9DF8ootL62hBguKuP8VvRxifw==
X-Received: by 2002:a17:902:7616:b0:16b:b48d:1ae7 with SMTP id k22-20020a170902761600b0016bb48d1ae7mr26067064pll.73.1657004637129;
        Tue, 05 Jul 2022 00:03:57 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t13-20020a6549cd000000b0040ced958e8fsm21786055pgs.80.2022.07.05.00.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:03:56 -0700 (PDT)
Message-ID: <3b1c6414-276a-0b4a-91b3-607cfae1ec60@gmail.com>
Date:   Tue, 5 Jul 2022 16:03:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     alexs@kernel.org, corbet@lwn.net, federico.vaga@vaga.pv.it,
        jdelvare@suse.com, kernel-janitors@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        siyanteng@loongson.cn, src.res@email.cn,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220704122537.3407-9-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 08/11] docs: ja_JP: howto: remove reference to removed
 submitting-drivers
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220704122537.3407-9-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAgNCBKdWwgMjAyMiAxNDoyNTozNCArMDIwMCwgTHVrYXMgQnVsd2FobiB3cm90
ZToNCj4gVGhlIGRvY3VtZW50IHN1Ym1pdHRpbmctZHJpdmVycy5yc3Qgd2FzIGRlbGV0ZWQu
IFRoaXMgcmVtb3ZlcyB0aGUNCj4gY29ycmVzcG9uZGluZyByZWZlcmVuY2UgaW4gdGhlIEph
cGFuZXNlIHRyYW5zbGF0aW9uIG9mIHRoZSBob3d0bywNCj4gd2l0aCBzb21lIGFzc2lzdGFu
Y2UgZnJvbSBBa2lyYSBZb2thc2F3YS4NCj4gDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWRvYy9hMmJlNDhlNS1lNTU5LTE3ZDctNWFlNy1kMTIwNWE3MzdlYTRA
Z21haWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3
YWhuQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFraXJhIFlva29zYXdhIDxha2l5a3NA
Z21haWwuY29tPg0KDQogICAgICAgIFRoYW5rcywgQWtpcmENCg0KPiAtLS0NCj4gIERvY3Vt
ZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdCB8IDQgKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QNCj4gaW5kZXgg
MzhmZWQ2ZmU2MmZlLi42NDllMmZmMmE0MDcgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRp
b24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QNCj4gQEAgLTEyOSw4ICsxMjksOCBAQCBs
aW51eC1hcGlAdmdlci5rZXJuZWwub3JnIOOBq+mAgeOCi+OBk+OBqOOCkuWLp+OCgeOBvuOB
meOAgg0KPiAgICAgIOODq+OBq+W+k+OBo+OBpuOBhOOCi+OCguOBruOBoOOBkeOCkuWPl+OB
keS7mOOBkeOAgeWkmuOBj+OBruS6uuOBr+ato+OBl+OBhOOCueOCv+OCpOODq+OBruOCs+OD
vOODiQ0KPiAgICAgIOOBoOOBkeOCkuODrOODk+ODpeODvOOBl+OBvuOBmeOAgg0KPiAgDQo+
IC0gIDpyZWY6YERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0
IDxjb2RpbmdzdHlsZT5gIOOBqCA6cmVmOmBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0
dGluZy1kcml2ZXJzLnJzdCA8c3VibWl0dGluZ2RyaXZlcnM+YA0KPiAtICAgIOOBk+OCjOOC
ieOBruODleOCoeOCpOODq+OBq+OBr+OAgeOBqeOBhuOChOOBo+OBpuOBhuOBvuOBj+ODkeOD
g+ODgeOCkuS9nOOBo+OBpuaKleeov+OBmeOCi+OBi+OBq+OBpA0KPiArICA6cmVmOmBEb2N1
bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCA8Y29kaW5nc3R5bGU+
YA0KPiArICAgIOOBk+OBruODleOCoeOCpOODq+OBq+OBr+OAgeOBqeOBhuOChOOBo+OBpuOB
huOBvuOBj+ODkeODg+ODgeOCkuS9nOOBo+OBpuaKleeov+OBmeOCi+OBi+OBq+OBpA0KPiAg
ICAgIOOBhOOBpumdnuW4uOOBq+ips+OBl+OBj+abuOOBi+OCjOOBpuOBiuOCiuOAgeS7peS4
i+OCkuWQq+OBv+OBvuOBmSAo44GT44KM44Gg44GR44Gr6ZmQ44KJ44Gq44GEDQo+ICAgICAg
44GR44KM44Gp44KCKQ0KPiAgDQo+IC0tIA0KPiAyLjE3LjENCg==
