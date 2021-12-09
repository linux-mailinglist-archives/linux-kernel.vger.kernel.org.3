Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657DC46F434
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhLITsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhLITsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:48:17 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DB3C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:44:43 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id j11so6026782pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=YyCJJVppVowTxkE+zlT+lHTZu0h5h64AtApwEArmpFs=;
        b=BMyqtGe0atMVZcr+sc/g8yqBeAyYfyA6HAJZyetaLAHuOkiytwcfayZxHUqHAE9Jyw
         A3YeHooaKkak3BNiONcYtD3rxLWiEzuTMEMMC94J56f2MSFOyLkTY3PK1gSprakz96u5
         Nh+Su6cw+1mksFhUqM+SLIkd9Cwz/hjmJeM9lRbiABMSCVK0XqHL7oKPTUPmD5VThpvL
         WnJc3nGC6dtm6X1RgQUcXeWEYg7SiIzj+Jfy5zJMhwS7FY7FPEq6e0H3zBQ/T9j9ie+L
         qVpezx2U4+oQ3xSlv573k7Hxs8xEk4siIjMpx1B19DPCpEJmlY6YFwyJj43mTT3vPwdF
         yNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=YyCJJVppVowTxkE+zlT+lHTZu0h5h64AtApwEArmpFs=;
        b=0CLBcWOLG7nwFehj0jlfSeGGpFcn9L0ckmWz4TU5MQilj1V0RxaQxkHXgcKbsVyeBv
         olsprg3JJdub3HjsKb3DibOJxHT56eL07EHmsx9iCl9a9o3rKUnD4ck1ZEe5++q4NWy/
         aLyyD09iGhjMtCboFC5+wvevFeO/WTVNSKe79Gr55duyoVLfzGy/S9Bhgo6pherJanW7
         gCWeCc/LQ5TguOOa8QZgpxeIZwH8JraixL/GI9Tkzbda8NFpqIyQnP5j+FT9VAgJxDQq
         82qMiLqd4rbGJ6Isfyd04uRoj7EQR4nwvumAcn+/q9B9keLUhmwvyvUR7VpaCdzvRhX7
         DhMQ==
X-Gm-Message-State: AOAM533bfbx2Dq6vlarGgVmqsvgphqLF1etKjZ4acrYcufSf+3F6GwGB
        1gfmsEUNssYs6Xj/3JywupRXuoB+WI0fGoUTxcnsjd8DS7754g==
X-Google-Smtp-Source: ABdhPJwUxeZjuiA/dIvPsn42rsoytsNIhwGZFU49P3dQ4NIGS+PSXe9f0kfmvd/9vdnE7OFnIbBgtbt9oaJp2S7f5R8=
X-Received: by 2002:a62:14c7:0:b0:4a2:a6f2:2227 with SMTP id
 190-20020a6214c7000000b004a2a6f22227mr13714966pfu.22.1639079071152; Thu, 09
 Dec 2021 11:44:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8ec7:0:0:0:0 with HTTP; Thu, 9 Dec 2021 11:44:30
 -0800 (PST)
Reply-To: compaorekone34@gmail.com
From:   kone compaore <abbttnab20@gmail.com>
Date:   Thu, 9 Dec 2021 11:44:30 -0800
Message-ID: <CAEKSJ0SR0dz5xqno2b3txjix4ZOt17U4mdEq1Z6FTgRHxdKjTg@mail.gmail.com>
Subject: Greetings from Kone
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you and your family.

My name is Mr. Kone Compaore, the auditing general with the bank,
Africa Develop bank (ADB) Ouagadougou, Burkina Faso, in West Africa. I
am contacting you to seek our honesty and sincere cooperation in
confidential manner to transfer the sum of 10.5 (Ten million five
hundred thousand Dollars) to your existing or new bank account.

This money belongs to one of our bank client, a Libyan oil exporter
who was working with the former Libyan government; I learn t that he
was killed by the revolutionary forces since October 2011. Our bank is
planning to transfer this entire fund into the government public
treasury as unclaimed fund if nobody comes to claim the money from our
bank after four years without account activities .

We did not know each other before, but due to the fact that the
deceased is a foreigner, the bank will welcome any claim from a
foreigner without any suspect, that is why I decided to look for
someone whim I can trust to come and claim the fund from our bank.

I will endorse your name in the deceased client file here in my office
which will indicate to that the deceased is your legal joint account
business partner or family member next of kin to the deceased and
officially the bank will transfer the fund to your bank account within
seven working days in accordance to our banking inheritance rules and
fund claim regulation.

I will share 40% for you and 60% for me after the fund is transferred
to your bank account, we need to act fast to complete this transaction
within seven days. I will come to your country to collect my share
after the fund is transferred to your bank account in your country. I
hope that you will not disappoint me after the fund is transferred to
your bank account in your country.

Waiting for your urgent response today
Yours sincerely

Kone Compaore
