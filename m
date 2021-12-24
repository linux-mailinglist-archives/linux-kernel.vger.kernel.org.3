Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2AE47F064
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353310AbhLXR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLXR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:29:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F6C061401;
        Fri, 24 Dec 2021 09:29:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so35659158edv.1;
        Fri, 24 Dec 2021 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d++DuyGAvsDciM6eGzuNhohbcfflkfo8Updj8Oi3lko=;
        b=Zcgxx/PFCm1Gk9GInJ75jZeRJmqq+ExTbcJMmRAvxyiOVA+59v9fa3/PuW3YvcvsDF
         g85lUn+o/rV5qvQGZiSuYuT+rLAwLPTeEAswjwVl2rNPxELY2uuymt+2Cf/jVIn8yATz
         ebKzbFXBB5ZkbiKrQnkh6i/RpKyZNGuCUlkp7JdSFASSS98wdgmqe4yhJgRQcb8VGuhy
         NEPmU/3iHbo5x/SO1JoU57djIwQzdt4IWlrTSY9nWipTxtfGe7KP2jof41JOCvMuFVCz
         rH9AR/PQv2INTq7/mlz0JHx2gdHAbLYUtVG/AXnE3RJmzCA+B8h/72Ff70D3rAwrJTGO
         c1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d++DuyGAvsDciM6eGzuNhohbcfflkfo8Updj8Oi3lko=;
        b=YUKSat71CZB+oQl5xi1yLCpAY8cSq0bd57NplGikGQPSsX1sTdWdb45m4oK2vhOZeL
         Y+AJDz6kzlU3MQT/eFKEU/JNtXmIp0qvaNoocJq5UI/2PvMIMjvXRAiXAhIxaAPsli0N
         NaN80uT+O7+fxvZ2AvREcRKuZox/MDRJs/23wrIBp59qoIOCbzlVCUBw8DCCvS090sXC
         hkXGvzmjwGaLWFOl3wq38KC//UwJVmz1qx9/f4pCMpPnqFSL0QXfJ0QMTewXw88VfVWV
         ucVwZnZeCpUyEK2tL4f5mCJUxWkIW7B8L4DyYQot6fMtWQ+zxPhGFRpHNT5kGUcBhyuz
         sTBg==
X-Gm-Message-State: AOAM531agVeI4Cmt0w0hWGZ3HoASBM2m7q5RrYXFm2qPHCWtOai3kqc5
        3UIty0Firro4V1fSkL6QFSy9JjxdHkTfCU3xDJg=
X-Google-Smtp-Source: ABdhPJy5VXGB5ok/CmgPeHloEn/RJrG5bmqnry8/oB6sB1YLfj9+63el5LzYjEmKrtfP3c0Dlx2ODZUCIBVT/XgsVe8=
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr4538306edd.29.1640366965079;
 Fri, 24 Dec 2021 09:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20211221030146.522-1-xianwei.zhao@amlogic.com>
In-Reply-To: <20211221030146.522-1-xianwei.zhao@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 Dec 2021 18:29:14 +0100
Message-ID: <CAFBinCDgQbjZ2QyTBbFuj--e6=mdxcd1PgYJNZJQFEvo3vco5g@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: serial: amlogic, meson-uart: support S4
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, kelvin.zhang@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 21, 2021 at 4:01 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
> Add serial bindings support menson S4 SoC family.
please fix the typo here: menson -> meson


Best regards,
Martin
