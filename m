Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110614749E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhLNRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhLNRoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:44:16 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:44:16 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id j2so48063964ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=PfoYgcipC9Y7C9digySG/2PxRiKalskspP/H05K47dw=;
        b=V0WbstQ1d9LB2zEDON2R+nzQUVOJ2RHl95id8pu1UpgVrl+LBAUKeuK9CrIjAlSjf7
         8TP/kNuBK8yRYMb1+qhJ9VielUmN0TGizcDV8yVQqwB9HxCSGVfX3/q9iS78Gj8PqNAk
         PWLG75k1yz78bEuyt5Do6sYvw/DnJYYPKw10ugDICpgA3PpnIZdXkQflqq9YdQUI1TPf
         pfgWhuqaduRiEhoF4AbUah9otYFVx9banigu4xKpG80untJzMa8r33p+qGuMcOj/9eIb
         0MADQIfqcvK3LLm9Yskj3Bgc4bNSYXHnY9aBJYlphpTzDUDvHst4E93Gyu0PVMe40Wns
         kkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=PfoYgcipC9Y7C9digySG/2PxRiKalskspP/H05K47dw=;
        b=Z0wvr8y/cNS1On61XZzTKLz/cIBeMYm7pbOjxiL0Jo8VgxDaPCo4sXGZwo2bcQGPQY
         y6j0T6VRvsDXxt9akJZfYejpT6SQ9T6ebegyn9bIt8sK/Fkqeo/Uqw8esTzHTdiAnyfc
         JIw0eQmDu1sUSbLV0f07cre3FyXQW8P8zvtqrlcZ5FMvUwGtnuHRD8mBDHX25ulA+Sq/
         4AFzZDIRjV0VaMpXfmmb5J+kN38HD6e5+tj5aZhcXyuxSge5i92ZiBSwM34MNkCDcl8T
         F2YW19vdxHXZ4ppf7YztZU18OOqGMlaIbyCWUAYz3GMO2/bM8nunue+4II37IAJ1Hiy2
         PIbQ==
X-Gm-Message-State: AOAM530B1YgeFZ7bMvn+3wMw5aMRxKNuicnwAxxPFTcmaaJke1uy3n9W
        D/bQlBdMWpxzSj6aIv00AJdazyazXBPRlzmvSPo=
X-Google-Smtp-Source: ABdhPJyYFnVfQdSo7cKo4C9ZYduStvOH8YhhwM3w8aSnmd31zN6E8qauVYy0+QxQapi0Cd1cI3SyInyY1IR7kWKKs3w=
X-Received: by 2002:a25:cc91:: with SMTP id l139mr427645ybf.325.1639503855469;
 Tue, 14 Dec 2021 09:44:15 -0800 (PST)
MIME-Version: 1.0
Reply-To: garnerjulianne64@gmail.com
Sender: merrynancy31@gmail.com
Received: by 2002:a05:7010:5f2a:b0:1df:905f:9253 with HTTP; Tue, 14 Dec 2021
 09:44:15 -0800 (PST)
From:   Garner Julianne <brownmonica152@gmail.com>
Date:   Tue, 14 Dec 2021 17:44:15 +0000
X-Google-Sender-Auth: 3f2wDb3ZPFZ1I9Rz-FVnmg3OPxo
Message-ID: <CAKqzNawFGcjyLiqDgaiCuNWWQjGbDE_y7pP66tRU+mGQY+BGqg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, did you receive my previous emails?
