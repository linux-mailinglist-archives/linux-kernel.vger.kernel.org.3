Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC448D262
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiAMGlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiAMGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:41:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F76C06173F;
        Wed, 12 Jan 2022 22:41:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e9so8312347wra.2;
        Wed, 12 Jan 2022 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Xg+BOiKiD1c2FZJR0vaNFinKRSO6AntnP3Rze4jrAw=;
        b=nu9Qw8D9KS1z4byrhCWEi5hjccg8BLk2Rw0FN6LOz1dYXg3ww3KHMSAGrf/v3OHHfQ
         zYr3GOdhdgzLLdr58ZndCQNI1YAUjFkwDKmXzE+4EThY5w5Nsa0c60aXzWlTE9vry8XM
         iQ0/Tna0pWNY/T8tdlNs+Ve24lRUUsLMG1M0IfrjTuPeJVxBOKfqT4XviFhIz6vnFxFh
         KtAa2cqEM7/KEuOfjELc356c0RnVdwTWSMiAQFPLjXVgEA8A0KaHzUKvLST48ui/8r6k
         lkaTISS1/vhzWZPJGv597g4wW7cNkz3Tc/PIKFa7HPuJ28QO9gS7dUWQtducTEP/5owb
         yo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Xg+BOiKiD1c2FZJR0vaNFinKRSO6AntnP3Rze4jrAw=;
        b=N1fhTC9pGKNNL5dU3cOp9ma0O6geYrfZg1Kf6u8gaT4YHYphu7SvAcx4LGSn4zGQl2
         rzttW/+L+Voyq95tVRkjfvTDExvbTYeAU1F/v0nn9IhS75Nj8ssdCWkZxNW1iYkiI8Z2
         YBoez0ZS0ANiVqwoWdwCUc7LDE+FIVJ/T4P+wEHygCtnmDxa/ZK2YvhmEnHKwU9Jy6Xc
         VTnRkVmpercbKIV3hjthFeakGjUPU05ikujjmGH9X6f0zSaHQs9hvEf+CxlNIW4UHAEO
         1FdDh3QibihGOj5BTLj3FQwHT8J9to8ww7xwExOiDcrYRY84VrEI60bIQer6mJyXNn9S
         pchQ==
X-Gm-Message-State: AOAM531CFTP78q5JXaBGGCxDIhMFd+mqAOQFeeyQvUvacum+qog4Q/4B
        1VwcfV0l+H5rl3EWbtNn0d+22Epqoy0=
X-Google-Smtp-Source: ABdhPJxf0SFvSpJ8mrrbExlOC7LfWtdpSMqUWplKTO2KutQEu9VJXG72BOcpKPP4TXaZ/nDeJRHung==
X-Received: by 2002:a05:6000:114d:: with SMTP id d13mr2706840wrx.32.1642056082529;
        Wed, 12 Jan 2022 22:41:22 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id c185sm1569402wma.24.2022.01.12.22.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 22:41:22 -0800 (PST)
Date:   Thu, 13 Jan 2022 07:41:16 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Transform documentation into POD
Message-ID: <20220113074116.3c9883d0@fuji.fritz.box>
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any news here?
