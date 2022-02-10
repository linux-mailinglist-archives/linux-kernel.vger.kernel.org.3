Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C44B0267
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiBJBbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:31:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiBJBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:31:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCB122533
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:31:12 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 9so4612143pfx.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JNuH55wTGRw2CNKCDmZpYRQ9FVq8mQbAJA/99Xvogog=;
        b=JGXX4ykemXQNdoTLEmz0NjLVOPq9hzvUeU/SBBNHvgfOoFfHFc+2JBBtgYlb7ih2AS
         4MxIlGUzOmnpldQOxuuouEQV+inZjrhMPm+YefMjebVbO/PY3af/iTvmMncFcZuOFISu
         FFa+lu4cPaKNs2fi1PSTSDYSYrdm1lrFYDct028sneLCxdWMIfE7kAbEgFWpT5AEgozl
         pUQCwY93U2MpLvHdWRj2aPQXvvtkquNep2RlBKFeZ1DzwQ0flb5w1lAYxHLwUay1Kaeo
         rz7lqe+ip3zF8wlv5YskSHt21q070KJfLHKsI+uEzYZ5Pfeaa946MbWyVvpkbcwPj0Lh
         9UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JNuH55wTGRw2CNKCDmZpYRQ9FVq8mQbAJA/99Xvogog=;
        b=FDAAiEaVBlnza2n/AUgm1/7iI4KFHJU6GzTm3qn4hGqtEJgo7SUZFFspddV8yKbYiI
         YADghybnpCc96PHi75s4K5MW16kEwcdZiaugojYex4lGredUhPmLuqLjvgDpgh1w/arv
         IOQInEPacVoZmwxw/fkX29u1AcI1CJXEVDfKrVRX3ZvxoQnxjAFp7GdUzc3F6yetEqOb
         bZ0q5z9UxvolS/NSNvuJC6/9mEDNlBR/Eawf92kdq5avr3Ef3Zj84DSi5N5SvYdM0F/W
         XrUPQ+0BsVWwjF4xL5xf39jnjAhFDR2iOuMNv3VFEEhwruAzHWApWN6eUaq/0BBDRdTo
         78Ig==
X-Gm-Message-State: AOAM532XNmu9DhidoHAFf0nxrSNs0Gp/hZTGQr7RjlgTlgZQYuFtw4HA
        Wz+LPDsvOVag6oFZ5hZ4GUwWbg==
X-Google-Smtp-Source: ABdhPJz8Wt+8lcJKZREuw8154zIwS0J+JbpHaY9co37OSVxEQFfth+/1EIUNNtqtIRoSxcqsPjQ3uA==
X-Received: by 2002:a05:6a00:1a52:: with SMTP id h18mr5152362pfv.72.1644456672247;
        Wed, 09 Feb 2022 17:31:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id lr8sm58982pjb.11.2022.02.09.17.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 17:31:11 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: remove CPU opps below 1GHz for G12B/SM1
In-Reply-To: <20220209135535.29547-1-christianshewitt@gmail.com>
References: <20220209135535.29547-1-christianshewitt@gmail.com>
Date:   Wed, 09 Feb 2022 17:31:11 -0800
Message-ID: <7h7da3o6cg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Amlogic G12B and SM1 devices experience CPU stalls and random board
> wedges when the system idles and CPU cores clock down to lower opp
> points. Recent vendor kernels include a change to remove 100-250MHz
> (with no explanation) [0] but other downstream sources also remove
> the 500/667MHz points (also with no explanation). Unless 100-667Mhz
> opps are removed or the CPU governor forced to performance, stalls
> are observed, so let's remove them an improve stability/uptime.

Just curious: what CPUfreq governor do you use by default for the
LibreELEC kernel?

Your patch greatly improves the stability I'm seeing, but doesn't quite
elimitate it.

I'm testing suspend/resume in a loop on VIM3, and with schedutil
(default) or ondemand, it eventually hangs.  With either powersave or
performance it's stable.  

Kevin
