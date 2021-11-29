Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAEE4617BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbhK2ORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhK2OPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:15:43 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643FC08EC8E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:51:49 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e136so41866301ybc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Wd83ufqq1kJkEn+Hkxr7W/erBVNC1WQEguDsy74kVw4=;
        b=Jr8+LJrEmOaKdTp13JGlE+2Ebdy1lyEmIs3FwGeTTDuzlUN0Xu2oOlwvHUpm+ShFC4
         a2/p8yZ4LXo2NlMS1rwO2tFdBrchSzog7NOMbLYpco2zKOww2UOMObcTAT6e08I7LVy9
         UNsBtNnLt3mj69OpPwkPtjuSsmr9OQYACUHuVLQHNnZo+DMZkhZnn5OKEzpef4djXwCk
         UbO/9VEPUvf6pw67W3blnqzyaq+T1fxteGe6Pce78tlvZ0wDjmdGqqOP5oR1cF+eTF18
         8owQP0+HUv64OHYrZD/tktJUHkW3uORD4EvrTDMNSa6/ijI0JAgWCfRewgR/loyZDCPb
         mkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Wd83ufqq1kJkEn+Hkxr7W/erBVNC1WQEguDsy74kVw4=;
        b=AI1ZR5Vzm0NQNlgXR9dG8BoQPwUxvnZtrUtVVkGHbRRmUgWEZ5Y4h3PCo55QdzqaJz
         5VGWxx6MqmUjx/kImaNGREdJ3OStfLRSwjgq9yUboR+0VaU4jrH5n+KOJIH2YoNaIb0a
         TQ4dOmbNP+KBCJMbLuW5806a8WlRNtpupCkeAQobQDd0hqaHbhx/kFPzITBLrAOQ1oNh
         a0Oh5HnfandbDZdOHh4J90+fH0ehP6WYCcsWihygarLDJFjitrMPV3dRhr6ksGMg8A2w
         U3TJ2VqxZFE30ENXNFzfrUgjP1lRlaxH7b3hWSUIL9rwUz/w3C35kMLqCRsA411EGhSN
         QXlA==
X-Gm-Message-State: AOAM530FEJQppDHh+V4AlVZyclnbPzpKBQeSD+3F32Xd9iiV76qF+tvn
        19AhxALsBcrx4BCoCEfUGkFBNxmRuY9ygr2kKtWG7pHltbIC7g==
X-Google-Smtp-Source: ABdhPJx3bQT26sEJIKD56i9UmNIw+aJ8Or9O41osfQUJoZbL8hzOw6bGmymcKvkxptOot5dM8SAZmFO50ASeJl2ykWQ=
X-Received: by 2002:a25:26cb:: with SMTP id m194mr6419159ybm.558.1638190307798;
 Mon, 29 Nov 2021 04:51:47 -0800 (PST)
MIME-Version: 1.0
Sender: traoreahm11@gmail.com
Received: by 2002:a81:2746:0:0:0:0:0 with HTTP; Mon, 29 Nov 2021 04:51:47
 -0800 (PST)
From:   "Mr. Abderazack Zebdani" <abderazackz@gmail.com>
Date:   Mon, 29 Nov 2021 04:51:47 -0800
X-Google-Sender-Auth: iwJqWvG0bm_TztJTqo0SiEItFP0
Message-ID: <CALBWaBaUwTZLudjba0sHGPYMnusOBVz6pVWpOgAGmhigNWcVrA@mail.gmail.com>
Subject: Hope all is well with you and your family!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hope all is well with you and your family!

Greetings my dear, Please permit me to introduce myself, I came across
your e-mail prior to a private search while in need of your
assistance. My name is Mr. Abderazack Zebdani, from Burkina Faso, I
work in Bank Of Africa (BOA) as Telex Manager, please see this as a
confidential message and do not reveal it to another person and let me
know whether you can be of assistance regarding my proposal below
because it is top secret.

Nevertheless, I want you to understand that there are still genuine
and legitimate business class persons in the internet world today so I
am assuring you that this transaction is 100% genuine.

I am about to retire from active Banking service to start a new life
but I am skeptical to reveal this particular secret to a stranger. You
must assure me that everything will be handled confidentially because
we are not going to suffer again in life. It has been 10 years now
that most of the greedy African Politicians used our bank to launder
money overseas through the help of their Political advisers. Most of
the funds which they transferred out of the shores of Africa were gold
and oil money that was supposed to have been used to develop the
continent. Their Political advisers always inflated the amounts before
transferring to foreign accounts, so I also used the opportunity to
divert part of the funds hence I am aware that there is no official
trace of how much was transferred as all the accounts used for such
transfers were being closed after transfer. I acted as the Bank
Officer to most of the politicians and when I discovered that they
were using me to succeed in their greedy act; I also cleaned some of
their banking records from the Bank files and no one cared to ask me
because the money was too much for them to control, They laundered
over $5billion Dollars during the process.

Before I send this message to you, I have already diverted
($10.5million Dollars) to an escrow account belonging to no one in the
bank. The bank is anxious now to know who the beneficiary to the funds
is, because they have made a lot of profits with the funds. It is more
than Eight years now, I don=E2=80=99t want to retire from the bank without
transferring the funds to a foreign account, I only want you to assist
me by providing a reliable bank account where the funds can be
transferred. The money will be shared 60% for me and 40% for you.
There is no one coming to ask you about the funds because I secured
everything.

You are not to face any difficulties or legal implications as I am
going to handle the transfer personally. If you are capable of
receiving the funds, do let me know immediately to enable me to give
you detailed information on what to do. For me, I am looking forward
to hearing from you soon.

Thanks with all my best regards.
Mr. Abderazack Zebdani.
