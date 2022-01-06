Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140F64861A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiAFIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiAFIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:50:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D4FC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 00:50:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j21so6766114edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 00:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Mi9dE9v3clesKFNJCKPomwlLIYryYDWiau65fiIzcBQ=;
        b=V7lTgunXf9XZEnBHEj+RU5e4jBx7fot938s1A4X03IHQTFp/N2CtI7Zyo/C8wPpUZl
         4sKxB3WlMA0rE2ZjX55W+nefBDq9lED2NczyvWFRTMphtVFPBBZaBt0/EQAkEhWXZP9x
         idloWiaHQ3v+hFdcgTVDvrCDuV5SUHwl/elPXGFqpQvWVKTHspe8vSpOYpmGr7j6gBiO
         JpRDMdxIvUcDthNJJt13uJwMnzputoCmrIycJ8G5F9XjDhxlR7RVXaCzasAjGxmQcGdn
         ejA663Pf71L3X9NufpRFOccU8/BFPaoanhq5rCW4sYshF5x3J5ZtBgxFBOQlLHcnYqo0
         +ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Mi9dE9v3clesKFNJCKPomwlLIYryYDWiau65fiIzcBQ=;
        b=3FEtqN9Kz5fSDeCtm5P8WlWT99LBA59s0Bt//yONiuYII0+1UokFS79+e3/+RXAlxM
         7F/ZroKrpo1uWbUrMcyBt7dignOL5CAzGIgmpza8CFrx4jnQD62F1V/v83fZW6MqLcTG
         lDUhkPHOZ77DREMvvtUT7sJE4zQ5Pn2UXfCWgoWTV3dVD0WCggPVrWG96pqY23kotGrd
         DRoe1JiosCZUucR7vYRsX+WgDPjjCCZQzaiP+XxdS97u7LjvVhzJAHzA3AWIe6BP5oL1
         taalSilWMspLOwDImKD34OKQTSoA9VUpZWQLSsy++LYYqj/p0gPpsdRXi8oyk3s0PYbP
         lLog==
X-Gm-Message-State: AOAM531YTByuVVdiknUTV59zEaZUIjNRKvzxHBH3L15gXcl3gfG38Niy
        ZQ4EptPuie8LbWmpt8tPj/ABTlofCdTQTDkVW1M=
X-Google-Smtp-Source: ABdhPJyrf7BhYfjIsx35spIGtq0Dz5C5Pwa7hMjchHehJUbqmG37MOO0k8tfGDLrkxGp86RSc0bpHeJS+1FCXGPRqxU=
X-Received: by 2002:a17:907:7b9e:: with SMTP id ne30mr47534271ejc.24.1641459022893;
 Thu, 06 Jan 2022 00:50:22 -0800 (PST)
MIME-Version: 1.0
Sender: mr.handebbe@gmail.com
Received: by 2002:a17:907:60d0:0:0:0:0 with HTTP; Thu, 6 Jan 2022 00:50:21
 -0800 (PST)
From:   "Miss.Cynthia" <cynthiahazem11@gmail.com>
Date:   Thu, 6 Jan 2022 08:50:21 +0000
X-Google-Sender-Auth: uAmbsV0tXFox71nTsGAMyiWH4yA
Message-ID: <CAAv8afiTrwyBeYgZ5LzpPXehpJyO2tV6WgLSTxDVM+WNxx6rJA@mail.gmail.com>
Subject: Hi Dear !
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGVhciAhDQoNCkhvdyBhcmUgeW91IGRvaW5nIHRvZGF5LGhvcGUgZmluZSxNeSBuYW1lIGlz
IEN5bnRoaWEgYW5kIGkgYW0gYSBnaXJsLg0KSSBkbyBoYXZlIHRoZSBtaW5kIHRoYXQgeW91IGNv
dWxkIGJlIGEgbmljZSBwZXJzb24sYXMgdGhlcmUgYXJlIG5pY2UNCnBlb3BsZSBvdXQgdGhlcmUg
d2hvIGNhbiBhcHByZWNpYXRlIHRoZSB2YWx1ZSBvZiBmcmllbmRzaGlwLg0KDQppIGhhdmUgc29t
ZXRoaW5nIGltcG9ydGFudCBpIHdvdWxkIGxpa2UgdG8gc2hhcmUgd2l0aCB5b3UgaWYgb25seSB5
b3UNCmNhbiByZXNwb25kIHRvIG15IG1haWwgYW5kIGdpdmUgbWUgdGhlIG9wcG9ydHVuaXR5IHRv
IGV4cGxhaW4uDQoNClJlbWVtYmVyIHRoZSBkaXN0YW5jZSxjb2xvciBvciBhZ2UgZG9lcyBub3Qg
bWF0dGVyIGJ1dCB0cnVzdCBtYXR0ZXJzIGENCmxvdCBpbiBsaWZlLg0KSSBhbSB3YWl0aW5nIGZv
ciB5b3VyIHJlcGx5LA0KDQpDeW50aGlhLg0KDQoNCg0KDQrYp9mH2YTYpyDYudiy2YrYstmKICEN
Cg0K2YPZitmBINit2KfZhNmDINin2YTZitmI2YUg2Iwg2KPYqtmF2YbZiSDYo9mGINiq2YPZiNmG
INio2K7ZitixINiMINin2LPZhdmKINiz2YrZhtir2YrYpyDZiNij2YbYpyDZgdiq2KfYqS4NCtmE
2K/ZiiDYudmC2YQg2KjYo9mG2YMg2YrZhdmD2YYg2KPZhiDYqtmD2YjZhiDYtNiu2LXZi9inINmE
2LfZitmB2YvYpyDYjCDZhNij2YYg2YfZhtin2YMg2KPYtNiu2KfYtdmL2Kcg2YTYt9mK2YHZitmG
DQrYp9mE2YbYp9izINmH2YbYp9mDINin2YTYsNmK2YYg2YrZgtiv2LHZiNmGINmC2YrZhdipINin
2YTYtdiv2KfZgtipLg0KDQrZhNiv2Yog2LTZitihINmF2YfZhSDYo9mI2K8g2YXYtNin2LHZg9iq
2Ycg2YXYudmDINil2LDYpyDZg9mG2Kog2YHZgti3DQrZitmF2YPZhiDYp9mE2LHYryDYudmE2Ykg
2KjYsdmK2K/ZiiDZiNil2LnYt9in2KbZiiDYp9mE2YHYsdi12Kkg2YTZhNi02LHYrS4NCg0K2KrY
sNmD2LEg2KPZhiDYp9mE2YXYs9in2YHYqSDYo9mIINin2YTZhNmI2YYg2KPZiCDYp9mE2LnZhdix
INmE2Kcg2KrZh9mFINmI2YTZg9mGINin2YTYq9mC2Kkg2YXZh9mF2Kkg2KMNCtin2YTZg9ir2YrY
sSDZgdmKINin2YTYrdmK2KfYqS4NCtij2YbYpyDYo9mG2KrYuNixINil2KzYp9io2KrZg9iMDQoN
Ctiz2YrZhtir2YrYpy4NCg==
