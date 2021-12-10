Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883246FC21
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhLJIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:00:31 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:32421 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhLJIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639123006;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OBEXN3+J8NPwvzJeHEFksdn+3uj088q/3sXGKE144pc=;
    b=NXr3QQ2t7hG24aeMS2RUNDJaQMSPl+tgq8M7SdxTKb2XAUgeWaL96tl/+JHnhK3MoE
    9a7uy26FeLA3emxdc9ZWXJB9vaup4u6KXgCCS7v5IH4gPKI/aaulcU0rhSiuUNQzLQ9Q
    NYEaNAYcRwP52nzhBAxpyvhnh3sracnUe1Ffgbxe3zNLH0lQ3Bohr52YBIT7W+fXtZPh
    oXQynIfIh3yZ5KtnB/rdS0B4zqQwjREoYtxbiYxxBq+F8vQHy3pc7ivd4lsP5mYd4cQS
    tm5HVXMlz9oE6XVOJ3lVqeBu07DnIZrzufGPPrUS/O9gxyHMsTuhjmpQ0e7L78vbugBN
    bljg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaI/SfwWp+"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.35.3 DYNA|AUTH)
    with ESMTPSA id z09342xBA7uj5TI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 10 Dec 2021 08:56:45 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH v2 00/18] crypto: dh - infrastructure for NVM in-band auth and FIPS conformance
Date:   Fri, 10 Dec 2021 08:56:44 +0100
Message-ID: <3288406.bErb3Tvseg@tauon.chronox.de>
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Dezember 2021, 10:03:40 CET schrieb Nicolai Stange:

Hi Nicolai,

I successfully tested the entire patch set with the NIST ACVP reference 
implementation which covers key generation for all safe prime groups defined 
in your patch set.

Tested-by: Stephan Mueller <smueller@chronox.de>

Ciao
Stephan


