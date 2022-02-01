Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233714A567A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiBAFV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiBAFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:38 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B12AC0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:34 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so15153925oth.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvAQN8dUS0+XkffJ1XQgKjOB8AsXGCjt9K5IDpVPCug=;
        b=xrHWHKvjSM6yZ9sW/la0fVwj2uTq7ONafyoMhfEEQppdnMoAP4pDml/QEl6Ojzx4Sd
         yC4La9gViReoOr+gFQtK6Cf4ckGvlOWf/ClNEZut24TW2ydHS5LnMe7UN2fUVbiWarBb
         mH9rmpYfSs9MoItrw79RJ4+OrKqFNf5hdnBBz53hzt0OFkdIlMZbL8sUB89o39D8RTM/
         Hm1eW6R6T3Cp4J9wuRqKOFhc4q8+S09dGEVet8Ye+9ofhHZkb4maNNtI7xkTXOR9Me3T
         26M7aUvAgG+FCWFoLsGxguSMLC0P/CcoaiFUwGX+885wzFAOYj8WYLBaDE+KmgYEVYh+
         hSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvAQN8dUS0+XkffJ1XQgKjOB8AsXGCjt9K5IDpVPCug=;
        b=IBYe5nHkmGT/aO+lK1fSGjglqwUEnmreUZfPsRNW1QGRAjwFhciaHHJz/6atQZTUET
         ev8F2UhK8eaqv9oh0W1CQUIFqnqIDEaRPOyZ5KkFbJPDTFJj3Wk46msp5ZMZq+kjhNT+
         uRpX34c6l3CAS087RIx6NEF6nKEK+8sWT4oBHIqvDPnm8dsqpXP9ldtreNhJ6M4I3jG0
         vjbtEsP153ILfkOiopi6gpON3hgagaJQPjDx+XZPU4a7uA3ftKWoCny7epcpC7aBo4Iz
         wBhg1+87eiGy+Rk5tm3wRWCd6gnpI9NK5023HXxGRYpMV/BDcoKcB8gDDmhN9zMLJhZ3
         gFdw==
X-Gm-Message-State: AOAM531AxB25SWlCA3+FFrgIaFsSfnTrKBKxqADTOxbEW8bglzuB6zno
        sr40BZRyJT+USDoMbev7BzE+dhtU8Eq7MQ==
X-Google-Smtp-Source: ABdhPJxtSe8cPKNC5PUUwFsEvKkTGox8FyK3dfg5Eg9w9nIPzmLbFUbR1gVH3JNCGtSqxJ9Hty+CTA==
X-Received: by 2002:a05:6830:314f:: with SMTP id c15mr4916828ots.28.1643692834010;
        Mon, 31 Jan 2022 21:20:34 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] ARM: dts: qcom: nexus7: remove vcss supply which never existed
Date:   Mon, 31 Jan 2022 23:19:42 -0600
Message-Id: <164369277344.3095904.3596257991206574402.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211225212000.80459-1-david@ixit.cz>
References: <20211225212000.80459-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021 22:20:00 +0100, David Heidelberg wrote:
> Probably got in by accident, search trough documentation and kernel code
> didn't found any occurences.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: nexus7: remove vcss supply which never existed
      commit: 3be5acc8586bde3884f61b78e915a468b01b3a9d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
