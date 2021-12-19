Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F71447A10A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhLSOyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 09:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhLSOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 09:54:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE1C061574;
        Sun, 19 Dec 2021 06:54:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so28081974edd.3;
        Sun, 19 Dec 2021 06:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=97q7sg0TD+CFNjCZu+yqt+zOFqMiYIbWb3t36ZIak30=;
        b=pFN23c6IE7GHNyY1lrHvdR6qK+ws6rcviNC/bAeDyKxtjctrPyWsEBHD9px91B4TFU
         XRqcKkBPN7TfDLY2hZ6TQMHtVESzgq0DShrU2vEuUTIVmA7GnDtqJ9GAaN8MaG+x0uKV
         MAW2VTfa1ReT6Ie6NrgSfz/CWqljNEg4cHUUo/AxBlnanGPZN68m4q6x7AngWcOmo4gV
         WjYYzn8izyiRudP6U2ttfthE7qA92G4TDzzCb8GX78/Ey7OJnDXIvNzD8Z+qysuSlb1a
         ApnhaSH7v9iMJ7NpjQrIbZjVqUcIt2BrIW3AquJqVXaf82gxGr/VfPzmcmGQabu4rzrd
         quCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=97q7sg0TD+CFNjCZu+yqt+zOFqMiYIbWb3t36ZIak30=;
        b=pR1BSIHdXUv8x1Kp5tbPNXn82J3j/zGBHmKf3HbYe7JI1vE5rgK8dc6NBM1gP+sDtX
         2R95yxbAnW7upIatD0tWLAxGRYVRMofaiT/u3ooqvbCu/Whc+8wBVCykl1tRzOk/YQoy
         qxQ7S+8PkuNctzslh3FQivlAuuu3RN+/kB2fnbDxSAHDrWcqRzBqP/yfZXpXDDGa437f
         5jLeuLXIZOIDYlQ1b4z6S/nt37mHAPfNTuToljyw5RgT7BqNnxH5WrpTFGlxnKTyyh0D
         XRaeBlbshU7opkQNK5MBwaqfb8eal8kfZy3YsSqJ93Tn6OwBImDOz/gmXEKakB3LiUfI
         r24g==
X-Gm-Message-State: AOAM5315A1MAbSs14kHZJDrkGMve31fZmDzFCUOp3MYgHkdsPXHI1rRQ
        r6DXI8pYeBKEg/Bz1OcBG6Q=
X-Google-Smtp-Source: ABdhPJzondZ2Fr1IDbk1rclTZfI5kulmoCZ7vS+Z/X5MrLtC4IIs/5DFD7TnaBMwzKgs71VYe4iJhg==
X-Received: by 2002:aa7:de86:: with SMTP id j6mr11678743edv.1.1639925673880;
        Sun, 19 Dec 2021 06:54:33 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id dm7sm1505647edb.7.2021.12.19.06.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 06:54:33 -0800 (PST)
Message-ID: <b244735f83010fe198ead3b818ee0718dc654879.camel@gmail.com>
Subject: Re: (subset) [PATCH v4 3/7] dt-bindings: arm: samsung: document
 jackpotlte board binding
From:   David Virag <virag.david003@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Date:   Sun, 19 Dec 2021 15:53:36 +0100
In-Reply-To: <163958527260.183299.17749602272220762675.b4-ty@canonical.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
         <20211206153124.427102-4-virag.david003@gmail.com>
         <163958527260.183299.17749602272220762675.b4-ty@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-15 at 17:21 +0100, Krzysztof Kozlowski wrote:
> On Mon, 6 Dec 2021 16:31:17 +0100, David Virag wrote:
> > Add binding for the jackpotlte board (Samsung Galaxy A8 (2018)).
> > 
> > 
> 
> Applied, thanks!
> 
> [3/7] dt-bindings: arm: samsung: document jackpotlte board binding
>       commit: c96ebc5fde274edcc02543dcfb6a1ee097f98070
> 
> Best regards,

Hi Krzysztof!

Thanks! As I'll be sending v5 of this series soon (only really adding
r-by, acked-by tags and only real changes in dts/dtsi patch), should I
omit this patch from it since it has been applied? Or should I really
only send the dts/dtsi patch at this point? Sorry if this is obvious, I
just haven't sent that many patches before to know this.

Best regards,
David
