Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8868046B56E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhLGIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhLGIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:17:14 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE167C061746;
        Tue,  7 Dec 2021 00:13:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id t26so31633845lfk.9;
        Tue, 07 Dec 2021 00:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8VBBrS5Mji35H9dzLgGDSTzu48sYhkKhDmT2w5684vA=;
        b=eyXrksDMf/c8wg8yU3nEVAiX4ThD9uL4nYKBMpSP08/SJDscsXoQ3FzXsgC9+P3LEe
         A+unKaG3TKNJcWInaAHtmO01SNVmsc3kQHsY/JpdfgBzKEHUapjP71W1ba0+WyYMosG9
         MGsgDAxpp5uM74/IyF9oJGD9/y/iAS6TG+lyA4t4SqTTmy0zPVEnMrhQU6xPCTJohUU1
         ttXiyiRck6cuK0fterlCb1n9EH1daWTCRC4XLUqtBvVp82MYWo338tPocDkQ3Typ2/fo
         7/r0Wso/pdbrybIDMf5Vigw0KoiUs+8r7tmdu8nZucPx8WSLguXLFZHuAW+7YAE6VF21
         Ab4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8VBBrS5Mji35H9dzLgGDSTzu48sYhkKhDmT2w5684vA=;
        b=i6v63kNwhFfWLpK5EptpFSH2xVNc6I4ZHCDo0iS8yt1xcFDoADp/AVG3DIe3jCwXfc
         PDUg+CVKefgBqVwiBDagmQQ9EnTPsQYM0uhZN3I4143nUWlM80ZcPi0hcSKQtECHtYcK
         OR9cvLQIAeBJ3dtwVShmWtnDinRGisgL02OmUAZJy8y6QaDOekuss0HrqC1Tn35VZ5NW
         wXMzuWEsGWOoyO4VD6otfTxRyTb/kiIt3yNLajPSpl4vSBzPp1SFFcQTX0o7iqJLijqn
         5wmXwPuizk7X7ay2bxnedNqpcc3agEHbIry5KUwnUdnpkuT5q6lwrWzs6klU2PHgelbD
         Kd4w==
X-Gm-Message-State: AOAM531tQNNzMGDe8DV9HNogMQCsUF+xIg9uI+3wsT9ks0zECa26yHqv
        nGLIGFtqcMi0AXy77OSm8GI=
X-Google-Smtp-Source: ABdhPJzvorYiMqU8lsAb1gx1vK3Pmj3BOFvmYw5exgUvQft5nH1yGsRO1olpZhwCPkIhGOaZq5LqrQ==
X-Received: by 2002:ac2:4c4e:: with SMTP id o14mr40231404lfk.148.1638864823066;
        Tue, 07 Dec 2021 00:13:43 -0800 (PST)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id p22sm1599842lfe.257.2021.12.07.00.13.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 00:13:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 3/9] arm64: dts: meson: add initial device-trees for
 X96-AIR
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20211130060523.19161-4-christianshewitt@gmail.com>
Date:   Tue, 7 Dec 2021 09:13:38 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benoit Masson <yahoo@perenite.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD127A47-ED36-40C6-B3A0-238166F727E7@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-4-christianshewitt@gmail.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Christian Hewitt =
<christianshewitt@gmail.com> w dniu 30.11.2021, o godz. 07:05:
>=20
>=20
> =E2=80=93 2GB DDR3 + 16GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
Tested-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com> #
X96-Air with 10/100 Eth

