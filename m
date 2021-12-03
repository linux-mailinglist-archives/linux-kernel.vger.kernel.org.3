Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA4467F90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353851AbhLCVyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhLCVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:54:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05971C061751;
        Fri,  3 Dec 2021 13:51:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so3221994wms.3;
        Fri, 03 Dec 2021 13:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=T1YDyHS3bivFJyZ3dufix2vYITOMIJgFkkiLcVXZbqU=;
        b=Z4JbA81IwNdeFi3ph3eBhFU8btzJxyhY5O5086Si9YkI3RRmCaCaMHr0/i8y8i4H4v
         U0s5XK04ep/4DvbP0hrQs4gtzu0pp7NfEJQuIqaUIiE1XcCc/d9/EY4IvcmTTGa976vi
         047AQifGnYRyIauwxE0ekI4tZzryptqgORviYnqA2I6vV6djPIIfuTtxGcguCXA51VEB
         vAegp2FXmziaIF8v4aYfr+fxGht8qrDEobEDjoWryRN+xNnJsqRW2lq+9NIg1kuXsFkD
         lEb4Jgx+WrkbiTSsanMg6Q3eN1VFhehL4nH7HZjX1PtUN3JrRfllOYUi6ypgTC7mWAfl
         MMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=T1YDyHS3bivFJyZ3dufix2vYITOMIJgFkkiLcVXZbqU=;
        b=pW1V0f9HcNoL2vvF6QlYHDb3+A9b7hINc2wfPCmHimJEZi4tzCE5HoK/bOe/lraMCJ
         YUpNQ56tPia32xyPurOgxohp4HVXLnM8QAfXNro3B5/Iy9JGlMyvvwthdqx2lVu+unLQ
         NVou7RYnzW5HJ80thpoJxBVC+oGRROT//snJLAF/RTDhCnb/D4g0CK+G1c9N/Z9cqY3t
         T118U/k2A3ClvT/8wwPmTWYtu4hU43bksuJufdYirmeJoYgHYHZtseX5KSXNV6I/C1mN
         HeYVK9ny5sxXkqz2Swn1Jyz8B9I69WNZdW1xP1iLRyt6pLm2u5WYYsfNKdhXNR179xAw
         gQIA==
X-Gm-Message-State: AOAM530KMBuSFBrKV+LqqFwnr/UcNMXzD22V2QRzHDB5IPa5EHMNKfnQ
        ue9FVb+Rj3XdOc2EdMizf8XCRIkfqqz0RQ==
X-Google-Smtp-Source: ABdhPJwxRNV9FBaLaLF9BUDvSCiiE0WIZqEWhoZCmBAT1Lc+2ktsbNt62rvnbYSbSBl4oCyme+disA==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr17915640wmi.173.1638568269682;
        Fri, 03 Dec 2021 13:51:09 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id r83sm6312827wma.22.2021.12.03.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:51:09 -0800 (PST)
Date:   Fri, 3 Dec 2021 22:51:07 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Jean THOMAS <virgule@jeanthomas.me>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, konradybcio@gmail.com
Subject: Re: [PATCH v2 2/2] arm64: dts: msm8992-lg-bullhead: Add support for
 LG Bullhead rev 1.0
Message-ID: <YaqRS/f4hU2BXtCc@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211201231832.188634-1-virgule@jeanthomas.me>
 <20211201231832.188634-2-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201231832.188634-2-virgule@jeanthomas.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

> This commit implements a DTS file for LG Bullhead (Nexus 5X) rev 1.0
> with its matching "qcom,board-id" property.

> Changes since v1:
>  - Added "model" property to the DTS file

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Thanks!

Kind regards,
Petr
