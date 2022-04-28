Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08785512E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbiD1Iij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344385AbiD1IiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:38:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAEF13EA4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DBYQvN/5MSQRzjCWOAoBqlgy8xIwXFrPxzrjrPoRctw=;
        t=1651134619; x=1652344219; b=EC5xgzWff2R53+3GlpYB6Uk6qWhf8VgJLEA2Q/JMiTOkEW0
        c3qOzj6ApZyeFmAHQaqnvqxaPfnrwJL4AC1AJV+Dh83SJcIbc9BINRw8tNbWayMHU/JRmzNM6jZHu
        tETWW+9SZamznl68FU67YWNTtEodsgYLaqHIix3+84pC5sa5+KQ9DBlARMTqHsoE7AhS/Am6cELbV
        a6dfS7nxhIr4FQXDc3wtEUoKWyVk8UbcQhcyQpSvvmqAlp7npiLa3c1Kw5C7vL81ywZATXUkR9gMO
        JMKXAC43/8Lof1SWBw40bInt1ZZH98aH6Szn95A4G68L7psTKcivB/8tkZHm5AGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1njzXU-00GKKP-Db;
        Thu, 28 Apr 2022 10:30:16 +0200
Message-ID: <98a1bff1a4cc798f0a02fd10a5f3b291c68ad1d7.camel@sipsolutions.net>
Subject: Re: [PATCH 11/30] um: Improve panic notifiers consistency and
 ordering
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-um@lists.infradead.orgAnton Ivanov" 
        <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>
Date:   Thu, 28 Apr 2022 10:30:15 +0200
In-Reply-To: <20220427224924.592546-12-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
         <20220427224924.592546-12-gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[trimming massive CC list]

On Wed, 2022-04-27 at 19:49 -0300, Guilherme G. Piccoli wrote:
> 
> Also, we remove a useless header inclusion.

I wouldn't say it's useless, generally we try not to rely on implicit
includes so much? And you at least now use NOTIFY_DONE from it.

Otherwise looks fine to me.

johannes
