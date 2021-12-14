Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6107D473EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhLNJG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhLNJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639472815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MhQZAL2N5LocL/vbA/UW2ni/3/GSwT9dVjhAkNlaELI=;
        b=KEgNfH3lV6PTBneUa0Mkb+6FVLYy41e71qwbwYHEpveLOGaoD2icldOJHL5fnKXerpDpzp
        2x02/mr0fr6HE+kzbiwab+fqIZ1pJAaNh8ohRvdi3iYOBCyuQeHzaYb6HrDavefA3PyBW0
        lJy9ROuvpT5+3KsMm0D+Porok7ICOCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-a0nZvRZ8MqeITkluAMe-Ug-1; Tue, 14 Dec 2021 04:06:52 -0500
X-MC-Unique: a0nZvRZ8MqeITkluAMe-Ug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD2A13482D;
        Tue, 14 Dec 2021 09:06:50 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EF645C23A;
        Tue, 14 Dec 2021 09:06:48 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: librseq: update to support upcoming glibc 2.35
References: <1553328188.30888.1639432033281.JavaMail.zimbra@efficios.com>
Date:   Tue, 14 Dec 2021 10:06:46 +0100
In-Reply-To: <1553328188.30888.1639432033281.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 13 Dec 2021 16:47:13 -0500
        (EST)")
Message-ID: <87o85jsggp.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> You can find the development branch implementing this here:
>
> https://github.com/compudj/librseq/tree/prep-glibc-2.35

I had a brief look at it and it seems okay.

Thanks,
Florian

