Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDCE468829
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhLDXEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:04:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35378 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhLDXE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:04:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C73E2B80CF7;
        Sat,  4 Dec 2021 23:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC473C341C0;
        Sat,  4 Dec 2021 23:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638658860;
        bh=pEj5hRCWZvd40QG2TRA87RGycRnsmX8ktA9z+dyKA+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxGt0chc2pExVxyxCjovTqkiSyyGy8hlQrRSPyhhJ3esj9KfDvdylB1gYMw35T5as
         78qC65pl6tT8AxNWHuqmrSJk/q0spNLdBvlFfc9aw8sYQOK8NuAWXWbI5DoWfuYe+m
         IZb+wlLFGYrggJW2Cg7KGRA0rlI1JF//4e/M/Ffpg3S8/724UgvL5PErNCs2CG1LAW
         /8bTbKKWXbI28+Riy5wo0HZpxdL7RjApHNDJyOdLAiOxa18RqS9vqNUkHhZ8xPDHrx
         n6lGQMIC1uT9bN6/9nUXkpNclO99lvl97Z661h7k7rqAs1g4fUsQg5ZigMTby1xfoW
         e6XhtTNuXeM6w==
Date:   Sun, 5 Dec 2021 01:00:56 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/25] x86/sgx: Make SGX IPI callback available internally
Message-ID: <YavzKF3LooOmj3Un@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <d4c030fd6bc8d5a618204abaea4b97489f137cc9.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c030fd6bc8d5a618204abaea4b97489f137cc9.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:06AM -0800, Reinette Chatre wrote:
> The ETRACK instruction followed by an IPI to all CPUs within an enclave
> is a common pattern with more frequent use in support of SGX2.
> 
> Make the (empty) IPI callback function available internally in
> preparation for more usages.

Please, just describe the usages that this is needed for so that
there is zero guesswork required.

/Jarkko
