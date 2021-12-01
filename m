Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE2465573
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbhLASdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244805AbhLASdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:33:14 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7FAC061574;
        Wed,  1 Dec 2021 10:29:52 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id h1so9591264vkh.0;
        Wed, 01 Dec 2021 10:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7YiLFaDW4iChA8JpdI7VPAA6isWGCIppNw13QoZmyEk=;
        b=SLQdLRUtyVoaauNtG/k/G9iJjG/Sr8aAIGu9Im5JB3HIywJTuhpX0h5zkuUaEatssx
         /FDi9/0oi4p0lvT9l2518WoH5Gi7ZJaj6VY6GANu/h+eV1St+neOEPsWZEbLKMEcRtn6
         Y3RjObaI+JHfAPfztB/DqUZ8OCmCBvpBiVgVRizPnUdFACddXh2rSbyc8xUwMJzsJPwE
         BZ0Hd8TM/PDIhCbJdJtltjgqISA8LQoI5/qCJxLGa093AZEasFN2GMVRH34jWNAi5HXW
         s5iNomGlO174ORAnU7jQ+Wdcl/tpLQsawp2kSxLRAEGkL3s2CQn9Tri8W1qLdtybPuGX
         jLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7YiLFaDW4iChA8JpdI7VPAA6isWGCIppNw13QoZmyEk=;
        b=4ZhPtmx1Lck6O8BTM37RsXDRTb7zuaMiMCgcTIcgPjgHPkH8sZlYdAALPpkhjzIvKg
         zAbI0OouBCuhW9nTgyzsSAC5X1jKfSmxlAJNyeSDU2CP6mOWOQqMKCgSOMAwmoQnPKXt
         dwNKbuRRCKXsEY9I2zVdRedml/CJoHxYyLQdA4f8reW0tx5NATV3d34jywsa/G14wIC4
         n55CkBrcBHSA2Qw9ZH/GO7Sp/hRywXdPv5oJOXnVqe26kiaUKAIyPj5oEdfNqH355YiL
         j4zO+C2zEPFs05yKv6FT7IZZwWYmpBX4jie2KsifmeOyKwR2mlo/n+uhUJMHBTzj4MH6
         q7hg==
X-Gm-Message-State: AOAM532ld9CpGGRqxFwmn9tVDCD9yWC+5qnuNsxqxHtB3lzecEd3pN/K
        //mg4l/ultZxNnj/oKUE8jcB8hPevkmbTHr4Pmn0DgNL
X-Google-Smtp-Source: ABdhPJxPA5BsSpCURbtGt16DVQnyhPWdSV3tWFRgY1WsDmbKzIqZhoN1CpMkODZfAxUw6Z1sNpY+Iy5C0p84Uuuxzm0=
X-Received: by 2002:a05:6122:1813:: with SMTP id ay19mr10772881vkb.10.1638383391601;
 Wed, 01 Dec 2021 10:29:51 -0800 (PST)
MIME-Version: 1.0
References: <eb6d86eb-d156-d7ac-0965-181719023d51@molgen.mpg.de>
In-Reply-To: <eb6d86eb-d156-d7ac-0965-181719023d51@molgen.mpg.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Dec 2021 10:29:40 -0800
Message-ID: <CABBYNZLENxvXMCh6XbBSnu0jasV1F0QestEK5v2mnNUpJdw3Vw@mail.gmail.com>
Subject: Re: Unable to transfer big files to Nokia N9
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Dec 1, 2021 at 9:39 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> For the first time, I wanted to transfer a 2 MB PDF file from a Dell
> Latitude E7250 with Debian sid/unstable with Linux 5.16-rc1 to a Nokia
> N9 (MeeGo/Harmattan). Using the package *bluez-obexd* 5.61-1 and GNOME
> 41, the device was found, and paired fine. Then I selected to transfer
> the 2 MB file, and after starting for a second, it timed out after the
> progress bar moves forward ones and failed.
>
> The systemd journal contains:
>
>      obexd[21139]: Transfer(0x56243fe4f790) Error: Timed out waiting for
> response
>
> Testing with a a 5 byte test text file, worked fine. Also testing with a
> Galaly M32, both files were transferred without problems (though slowly
> with 32 KB/s.)
>
> Trying to connect to the device with bluetoothctl failed for me, and the
> journal contained, it failed.
>
>      $ bluetoothctl
>      Agent registered
>      [bluetooth]# connect 40:98:4E:5B:CE:XX
>      Attempting to connect to 40:98:4E:5B:CE:XX
>      Failed to connect: org.bluez.Error.Failed
>
>      bluetoothd[21104]: src/service.c:btd_service_connect() a2dp-source
> profile connect failed for 40:98:4E:5B:CE:B3: Protocol not available
>
> As the Nokia N9 was once pretty popular in the Linux community, I am
> pretty sure, it used to work fine in the past, and there is some
> regression. It=E2=80=99d be great, if you could give me some hints how to
> further debug the issue.

We will need some logs, obexd and btmon, if possible.
