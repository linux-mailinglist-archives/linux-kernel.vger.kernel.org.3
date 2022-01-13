Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658D048D769
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiAMMWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:22:14 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38665 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiAMMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:22:02 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 10C952223B;
        Thu, 13 Jan 2022 13:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642076521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jprqd+d1h/t5V8jJrlSZ/eucSzrsLK59TYo9EJ8r4VU=;
        b=vis0alKWx7es8Jtu1XusPIlAnQ4mgtj5HUc8Ugrux6PbRaXYt7+emaGgorK4+JMl/YMNIe
        cV+2W6Bj94jd1lSyaf8cYmrLjNiEYkqnlsAsey4Kht+AomtHgFld+cYViwVolacSi7S4Uk
        SjsFpH+Y7b5z5h+WJdWC4djXuraevJY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Jan 2022 13:22:00 +0100
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 0/3] of: base: of_parse_phandle() fixes and new variant
In-Reply-To: <20220113085208.2636517-1-michael@walle.cc>
References: <20220113085208.2636517-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <3072e2f28b4f2569f5861093768398c8@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-01-13 09:52, schrieb Michael Walle:
> This series is a result of the discussion in [1]. Rob suggested to 
> convert
> the index parameter to unsigned int and drop the check for negative 
> values
> and make them static inline.

Oh I haven't thought this through.. If this is going via another tree 
than
the nvmem patches, then I'd need either wait one kernel release, or 
there
need to be an immutable tag, right?

-michael
