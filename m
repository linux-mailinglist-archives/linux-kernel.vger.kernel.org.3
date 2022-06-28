Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE755CBCA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiF1FZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244711AbiF1FZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:25:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E133B1F;
        Mon, 27 Jun 2022 22:25:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z14so11173461pgh.0;
        Mon, 27 Jun 2022 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=pgonluzyL1h+kykYHqoeMzba6ZA6ttg4BlJry44nex8=;
        b=Y8M8fifZYgvmkexdtyaLShnQcaD3jHHKHf7dssYushX0hW0f8wBgxiV++I1pxCx4lV
         83c9fOw5M6Xwmyorz6eoee18QdevPjxGcEjsA81ltXTIYV5ZaRxV4kSIMOSE3qRtnRM8
         YRMV3TVLvFVDtYimxf9s++pcAwdGKDXoo7jnKVPbc5pztyUdmR5Hy9OyxZtsz0SYQroK
         5zLo2z2ueUVg7xbY2+ocmiCx7VdiljWbk/f7dUwT3ubL585I/Ca1I+OAeIR7FE7M1C8W
         94Q5S1K9+0D02ZqUnuipaYFlz4bIeO/uYFoXmHkZvh62f0R5WCRDjar4X49mAjFZgr3R
         ZkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=pgonluzyL1h+kykYHqoeMzba6ZA6ttg4BlJry44nex8=;
        b=JoG6YGu/E4SdP2IvBUiBS7UiHx3rlcsCLr/ZOKBo8QatsMvFEA4OmTz5n4/Y850x43
         IvPSvIETku70YoO0+FAozDEGO+cQe3wT1ho6baKEmsoH2+Xx5isBWXb4nPl4vhjFf+KY
         ePy7DppXncG61Tniqw0rPwa2V1yB80OSCzUrBxu/q0D19B4WdcgzLxGJFwLDAMVoxpfp
         qCKF8UdH925TpW5Dyh6xrl69D5kK0xqdZMV5JLxAQL8nbBtb4DmChebJfa5NJxwtAwLa
         IgVpKHs/1NNZX6wX2o3NT/F9+tyGKlbX/zGncvuYQtTvpEkwCD2NZIEDH6Pk2JpJz3jq
         Q/Sg==
X-Gm-Message-State: AJIora92hBD4HIil8jsSzDgd3ve2aMYbkSbTZAC2OdNJhERzYSJ42Rcc
        /qzTxjAdsaJBxdSWAuHQT2k=
X-Google-Smtp-Source: AGRyM1saugDpzmQnPjMdIM+x5hsbK7gOzY4bjoUJU98ivxmGXPnWENN/xbgWqWBrUPP3CiYfXqo0yA==
X-Received: by 2002:aa7:9258:0:b0:525:4214:e937 with SMTP id 24-20020aa79258000000b005254214e937mr1680782pfp.15.1656393931921;
        Mon, 27 Jun 2022 22:25:31 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902f34200b0016a2a8c7e8fsm8174595ple.143.2022.06.27.22.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 22:25:31 -0700 (PDT)
Message-ID: <a2be48e5-e559-17d7-5ae7-d1205a737ea4@gmail.com>
Date:   Tue, 28 Jun 2022 14:25:26 +0900
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
References: <20220627151819.22694-9-lukas.bulwahn@gmail.com>
Subject: Re: [RFC PATCH 08/11] docs: ja_JP: howto: remove reference to removed
 submitting-drivers
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220627151819.22694-9-lukas.bulwahn@gmail.com>
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

SGkgTHVrYXMsDQoNCk9uIE1vbiwgMjcgSnVuIDIwMjIgMTc6MTg6MTYgKzAyMDAsIEx1a2Fz
IEJ1bHdhaG4gd3JvdGU6DQo+IFRoZSBkb2N1bWVudCBzdWJtaXR0aW5nLWRyaXZlcnMucnN0
IHdhcyBkZWxldGVkLiBUaGlzIHJlbW92ZXMgdGhlDQo+IGNvcnJlc3BvbmRpbmcgcmVmZXJl
bmNlIGluIHRoZSBKYXBhbmVzZSB0cmFuc2xhdGlvbiBvZiB0aGUgaG93dG8uDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4N
Cg0KU2VlIGJlbG93IGZvciBzdWdnZXN0aW9uIG9mIHBsdXJhbCB0byBzaW5ndWxhciBjaGFu
Z2UuDQoNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0
by5yc3QgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9u
cy9qYV9KUC9ob3d0by5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9o
b3d0by5yc3QNCj4gaW5kZXggMzhmZWQ2ZmU2MmZlLi4wM2IyMDc5ZTRkNWQgMTAwNjQ0DQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL2phX0pQL2hvd3RvLnJzdA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9qYV9KUC9ob3d0by5yc3QNCj4gQEAg
LTEyOSw3ICsxMjksNyBAQCBsaW51eC1hcGlAdmdlci5rZXJuZWwub3JnIOOBq+mAgeOCi+OB
k+OBqOOCkuWLp+OCgeOBvuOBmeOAgg0KPiAgICAgIOODq+OBq+W+k+OBo+OBpuOBhOOCi+OC
guOBruOBoOOBkeOCkuWPl+OBkeS7mOOBkeOAgeWkmuOBj+OBruS6uuOBr+ato+OBl+OBhOOC
ueOCv+OCpOODq+OBruOCs+ODvOODiQ0KPiAgICAgIOOBoOOBkeOCkuODrOODk+ODpeODvOOB
l+OBvuOBmeOAgg0KPiAgDQo+IC0gIDpyZWY6YERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0IDxjb2RpbmdzdHlsZT5gIOOBqCA6cmVmOmBEb2N1bWVudGF0
aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1kcml2ZXJzLnJzdCA8c3VibWl0dGluZ2RyaXZlcnM+
YA0KPiArICA6cmVmOmBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVz
LnJzdCA8Y29kaW5nc3R5bGU+YA0KPiAgICAgIOOBk+OCjOOCieOBruODleOCoeOCpOODq+OB
q+OBr+OAgeOBqeOBhuOChOOBo+OBpuOBhuOBvuOBj+ODkeODg+ODgeOCkuS9nOOBo+OBpuaK
leeov+OBmeOCi+OBi+OBq+OBpA0KDQogICAgICAg44GT44Gu44OV44Kh44Kk44Or44Gr44Gv
44CB44Gp44GG44KE44Gj44Gm44GG44G+44GP44OR44OD44OB44KS5L2c44Gj44Gm5oqV56i/
44GZ44KL44GL44Gr44GkDQoNCj4gICAgICDjgYTjgabpnZ7luLjjgavoqbPjgZfjgY/mm7jj
gYvjgozjgabjgYrjgorjgIHku6XkuIvjgpLlkKvjgb/jgb7jgZkgKOOBk+OCjOOBoOOBkeOB
q+mZkOOCieOBquOBhA0KPiAgICAgIOOBkeOCjOOBqeOCgikNCj4gLS0gDQo+IDIuMTcuMQ0K
DQogICAgICAgIFRoYW5rcywgQWtpcmENCg0K
