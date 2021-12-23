Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5147E515
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhLWOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhLWOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:44:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE37C061401;
        Thu, 23 Dec 2021 06:44:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z29so22290705edl.7;
        Thu, 23 Dec 2021 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=Y6HKwPC6DjAMqeX8HR858hunWd2fFPpLR+z2PX/mMB8=;
        b=R3cWSJMAl3wNEBFA1/YJtKa+Cvcmo53dWvU2qTJx+fXLhCEVW1XKybBlwnjCrXS2D6
         xJYIuiV/knrvU2qYXK5iQL1ZsbJawR1m01Pn+L7pCBZru/xP0m35fQy4f3X3jPH7EPpZ
         Uje5JE34MBY+33vH31XMXyJar9tmkvJedNa0BUCmahyJsu5PhcavTp3Rtm2oi0YnsqyS
         6mu5mWQiITDXSTGGOcwjpToo8uLgoZjxhDWUxTdDbPqmYyQWMZKLKIocqUKKeVc9/WU5
         hWqY/wPWKI9mAFkm0x26yj3r+cS2AeYmzOKd87wrC1ZtnlANP8jmlczAkXTN3yPOszl3
         8Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=Y6HKwPC6DjAMqeX8HR858hunWd2fFPpLR+z2PX/mMB8=;
        b=WOQZuw8B8sAU+ZRU4D74xglzcgIDlE/Z+gw21DUiX3y8akVnwT5ibbLp0Ukzk97DbG
         uQsUNYYo4U/teOF6E96dpMdNFOpmG+KrVgN3d+/7pfE2Pa7tVCS0Q/Z6jBieizA3phU5
         gd2UQTbZrfSRtxjNpd17xiOK6vn4+R9nO3aepOC251ujv4fOrFvxJbGWSyKsijFaZf2F
         5GRyuKzuvx/UUYWTVCYO5Ic3EzjRH5Spfv1RzBmACrUR6J6z7ChphDU67Z+IGDoKseqR
         6PHd5P9Obj3TmQU4XeI+/wwXMDA37OlRiEWzIkhZmH2zDTo+/IS68JD1IeNIoAVvBLxM
         fIlA==
X-Gm-Message-State: AOAM5328wyDf/21Vczbkd/vg856TdxJ5DnHoWXo/vowc6pK36F8h327n
        jy+/G/gPhauVPtBwv7uU9TQ=
X-Google-Smtp-Source: ABdhPJxJMVmMIWzbe/OhVCW6laNXPBvuyepul4fTOMhcYemBst6k9WKlC5I86G0CXSk2huD7933Z3w==
X-Received: by 2002:a17:906:2192:: with SMTP id 18mr2066992eju.635.1640270650213;
        Thu, 23 Dec 2021 06:44:10 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id qt5sm1769086ejb.214.2021.12.23.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 06:44:09 -0800 (PST)
Date:   Thu, 23 Dec 2021 15:44:07 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, olof@lixom.net,
        quic_vamslank@quicinc.com, robh+dt@kernel.org,
        sboyd@codeaurora.org, soc@kernel.org
Subject: Re: [PATCH v3 0/3] Add devicetree support for SDX65 Modem and MTP
Message-ID: <20211223144407.GA6503@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163960723735.3062250.7838330411965052999.b4-ty@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, it seems to me like a patch similar to Patch 1/3 was applied
some time ago, see 61339f368d59d25e22401731f89de44e3215508b, and applying
this patch has caused the compatible to be documented twice.

Stanislav
