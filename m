Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE60F4692DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhLFJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbhLFJpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:45:07 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD65C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 01:41:39 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t34so10197365qtc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oTR4YORgOhY3LZUJXsEMNB6HtZnrN9lXkhFSnDL2e/M=;
        b=fRLZEvjnnrOfJqti0ObeNdInF1XfaBr+dcy56rPYjlaPsHdV7BonnsS+66IbuM/PYD
         HFMpjAv8Ca+byzKLVaJhTlIpkWUC8D/Fyxs8DDC4DswHtMEaLa7rHnupc1aSGxJZetWP
         rLb+6PeNgRDt+eZKeVk3uQJLNwJW/yJWA2TGXw89KMOhvSw6WiOH6KC44h5ivDpa8SLf
         AYXPFdin6C1ebRatKwfewOwBL38qiZLqHgVpwS0mngEhTuVBFgrXlAP9r6G0uWAcNQOd
         tDEV2eHFqzp2r4VReH7IDu5QkHJbPp3AutsMdQnbxS/eLC/7hHvYz4s9xIQt/+GdMu0q
         zyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oTR4YORgOhY3LZUJXsEMNB6HtZnrN9lXkhFSnDL2e/M=;
        b=kwEpFbo5WJFhwk7jmNp/xvC3BQsQgZ0iLSauhVsbbr1Nc/tdXYtQac6wqag+dooQO1
         xQAjDigbKB6hH8ZHY8N2QFzmOPQOJfwKguYHfSDXZb6NJKOxg8zOup4n4iT0rPrnIBXL
         EYnD+2GLYwi7r8hqux+v5KkAH7fd63yTmtjhR/rAbvHWbBZro4CgyyMni3+JzKjJz0yw
         Vc3wDZCh7ki6/IzeyWVllKfG5AM6XElaRxGJw5wyzA+W+d0PcOjqxKPH/nRINZF1/L8N
         HIQpY7dUqWVOMta0a6mQ+qvOeqtNUqDm6tpbQHNPbilRFWoPv4J68Hssr/b8r1iOt1XA
         W6Hg==
X-Gm-Message-State: AOAM532RD/inhhjn3y7HO17j+xUO7au1jW9uHDvfGtjhlfzEgostkXNI
        pSy8FfwQm18U+DCPKMIQMt1z698QXrKUrDgtTvcQQAOgTL8=
X-Google-Smtp-Source: ABdhPJy+KKxNvUmnT3KwoJGuplU9ojr3a1Z0N17Rvp4f9/IdvrOo0629iPB6Yve7at03taMfFgRvdiInkPMK5gFrUjk=
X-Received: by 2002:a05:622a:292:: with SMTP id z18mr38109291qtw.205.1638783698539;
 Mon, 06 Dec 2021 01:41:38 -0800 (PST)
MIME-Version: 1.0
From:   Dongjiu Geng <gengdongjiu1@gmail.com>
Date:   Mon, 6 Dec 2021 17:41:27 +0800
Message-ID: <CABSBigR+vkeLZhO-YnOZKo=P_ozu-EMiW35gQxwjVbZoqqAKHQ@mail.gmail.com>
Subject: RT patch for linux kernel 5.10
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
      I see some RT patches are merged to kernel 5.10,  such as
CONFIG_PREEMPT_RT,  but is not complete=EF=BC=8C it seems missing much more
patches for FULL RT kernel.
what is the plan that merge the full RT patch to linux kernel mainline
or kernel 5.10?  thanks!
