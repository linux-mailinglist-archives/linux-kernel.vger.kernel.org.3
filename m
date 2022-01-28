Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9422349FBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349166AbiA1ObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiA1ObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:31:12 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D7C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:31:12 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id z7so5545047ilb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=C4xMgyj4PqtHIb3s8cThAMh+Lh46iAIWuvrZD5QJYRk=;
        b=meqn8q3qmMhmPn7IHm22UydlMZsrXm+9hvsOeMI1iRsrsRx7XB8lCSlYsxIt9xmar1
         B8D4H3QswMrnOFa9JiWgcYTHgYFogl4JKKtU7a+owPCu0H7ZWukuGQ9pk8dhoRcLPoKX
         jW73S37bs0HQtK2I4KiKUK9UQJ0AUGkjXa0Klz45SaR5IQ/ENGnRpijaoHVqAUz69LsD
         BNyHD/v52LZEVxQybYcqq0P7SvVN3+bfiONv7TBFQOM4izLNacb0FiLvomxDDF28PcYT
         5448gBoWUOK7bZKsYQljCeVhh9E/VetVvK9zusF42vGOjATpV6fomcGMlN+csFVknEY3
         tcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=C4xMgyj4PqtHIb3s8cThAMh+Lh46iAIWuvrZD5QJYRk=;
        b=Ln4L1HYLjpfD4VirL6oL45JSdr5EbTzCc4LKPwUV50SiPI+D81+rVkYdeFdN4Ae3be
         P5DtAiH6GxjjjM6MlVDUfmx8pz/5LKCFj7ZQRl+pDFJNykVSdZS+a9YJHMOaXe2YbGQv
         91ar1SU5e4qYwbitg+nxs6UO/ezmiKjm5cBRFOHDHLJS81xp++hEIg+VxC91yxW4zxpb
         bJNykx3d2mWsv8rs+pTXprvlEEC4TEm7qGRKchGF360KrmTAhn5TqcJMa6Sx1Kl7mXpP
         ++iOy67O4QjHHHsMh0aZyskJAWi2LOx83DV0HbtIFvai4pAP/X8fHEjaWJ+k9FvbfulS
         mA7w==
X-Gm-Message-State: AOAM531H+Jg32y+h7OQa5pHMc/nFZX9mnVawkuQPfOCR0lcBwBAQiWIA
        h2fvv0vYL7w3dXNDzRNM923Xsu+8163FbOfrTyU=
X-Google-Smtp-Source: ABdhPJwIlR6QN9gEUt1QNafiQQTvcQbmWu08ts4aZeBcJTm4pDBxxahXyN4sFFtFPWtttwLRSghwwFtcZSKYlvs6Lpc=
X-Received: by 2002:a05:6e02:1564:: with SMTP id k4mr6165356ilu.63.1643380271899;
 Fri, 28 Jan 2022 06:31:11 -0800 (PST)
MIME-Version: 1.0
From:   Paul Mulders <justinkb@gmail.com>
Date:   Fri, 28 Jan 2022 15:31:01 +0100
Message-ID: <CAOn50SK+g+gqxBiuHACfv=a0SjSnmdeGbC=LQyniHsZZApvF0A@mail.gmail.com>
Subject: Re: BUG: [PATCH v2] isoc: mediatek: Check for error clk pointer
To:     justinkb@gmail.com
Cc:     broonie@kernel.org, frank-w@public-files.de,
        gregkh@linuxfoundation.org, jiasheng@iscas.ac.cn,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correction: the "(so no mm block)" should be after "and MT7622
doesn't", not before.
