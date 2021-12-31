Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03F448249E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhLaPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLaPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 10:39:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE4C061574;
        Fri, 31 Dec 2021 07:39:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j6so109796239edw.12;
        Fri, 31 Dec 2021 07:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SW3UGJt0QxPsev32JLznTOBLLZ4OhUVbGGpwoyykscY=;
        b=OfAaECPk0P5hfq1qHQWDOOUN263rjD3N8KhmaCbTvSMUep330PRpac+vVV2bWBd8U/
         Rz+uphwf9Y3LL97cnWMkZZ779FtJXRlVF96C7veSGCI/6djfjBF1OdSWVPHF3PZ6In3i
         CqtJxTZV2n7HPZfGd1Jq1bumoHTO8HFYosdPM89/UF5A1AaHwNNPpBEgaLDQillo2pI3
         +BKZ68Zd+v0pwnX4smfHRhGQtE2bAylVx1sdHB0tfSqDiLPFdSzwtq6CWMfOQ/FL6P6N
         ZKk5/iZeC3hT/ZQVTRI3xw89dJcOaj4Is/41XigmjdhZ3gvQ64S7DiOomyrH+Z+XEopD
         Wy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SW3UGJt0QxPsev32JLznTOBLLZ4OhUVbGGpwoyykscY=;
        b=WCU96E/d4D47+bAM4daX0XhXVaaCfkQHnyyq/KDdNCFW3m7hrwWNnWuXBcQijCTzBO
         KuVc/MmB0VciSmfYG8bTJ//j7RRgIbuhqiDizVU6XcfaC1ZS7kCc1SG0sylHgABIFREz
         GFPzfEeMmIDoEIvzx1418TGfTyRjqA/Jtj7XKPNo6mqOn0X9IeaSSQxp7eoG0DCyjULc
         HROedK/FQWmWeRO15gbCiaKa2Cs+KIhGN/0PGlud7Ub73HTpJsF/a4ZejJTxLjztKSZt
         oAYu1EkBDXUykZhtn9VyZMYBA20C12FaMpd3rjSGMRNQh4K4Kx2B1xPrk1vVMsW2g2wM
         DCfQ==
X-Gm-Message-State: AOAM532ZUnbWQCxM09yXbV1zBgUNSU8R/y6SWoSRm4LP2xdgCtkt5kID
        u00nyFT7b7xN3hP05sCvE1PlWpIA2pJcz7DJVzk60NXvvHE=
X-Google-Smtp-Source: ABdhPJyFaMZrwCkOWYrtCdpD+o3CHe9V4PGKreFCM+z+hJ2SEXILryxc6/TPnRRrjK/anfPm0dXT8mW1RUGcrgqtNXo=
X-Received: by 2002:a05:6402:1b9c:: with SMTP id cc28mr34324709edb.219.1640965148245;
 Fri, 31 Dec 2021 07:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 31 Dec 2021 16:38:57 +0100
Message-ID: <CAFBinCC7iSKjZ=U5PN5FKF9js77tvaQBdWdHMPp_y+u+asaeoA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: meson: fix UART device-tree schema validation
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Dec 27, 2021 at 7:00 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello,
>
> here are three UART device-tree schema related fixes for the 32-bit
> ARM SoCs.
> These patches don't fix any functionality which is why linux-stable
> is not Cc'ed on them.
The statement above still stands.
I would like you to apply this series to a 5.17-fixes branch because
of a change from the tty.git tree which will be going into 5.17 to
drop the "amlogic,meson-uart" earlycon handling: [0]

To make it clear: Backporting this series to kernels older than 5.17
won't break or fix anything.
Only 5.17 and newer will need this due to a change [0] in the tty.git
tree. Without the patches from this series the 32-bit SoCs won't have
earlycon support in 5.17.


Thank you!
Martin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=ad234e2bac274a43c9fa540bde8cd9f0c627b71f
