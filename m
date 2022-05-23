Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBAA53120D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiEWO7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiEWO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:59:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9289B5B8A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:59:09 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6655222248;
        Mon, 23 May 2022 16:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653317947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGj5h6n/mhpEpy/6trXc2PvmpwVRapEg4Ui9pjNgjCk=;
        b=X8G07+KlUFysKyCB10+5jywwKqQlpSDbTI+WOtIwm/bKeGpS0aNMPEKxV5rk0+QMblOTc4
        bqzbvI0SDmR8nAECqNV3TSO/65zTkO+TOt0GgHvmffOdwh5W0U/gw/JlrLlGGQEOFV5aE+
        QJMurQLjuz1ISSbq6gi1es8Lylt4BiM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 May 2022 16:59:07 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: Add support for mx66l2g45g
In-Reply-To: <fde9bd5a-7161-9222-4719-4279b2416163@linux.intel.com>
References: <20220523143002.1754922-1-jiaqing.zhao@linux.intel.com>
 <fde9bd5a-7161-9222-4719-4279b2416163@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <35d64d702798d437245090ce96ae29a8@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-05-23 16:33, schrieb Jiaqing Zhao:
> Use PARSE_SFDP for now as the SNOR_ID3() patch is not merged yet, will
> switch to it after it is merged.

Fair enough, could you resubmit it with
{ "mx66l2g45g",  INFO(0xc2201c, 0, 0, 0) PARSE_SFDP },

Looks odd, but is the same as SNOR_ID3(0xc2201c), so we can just
switch to the new macro without any more testing. Or Pratyush can
replace it inline while committing this patch if the SNOR_ID3()
will make it in before.

-michael
