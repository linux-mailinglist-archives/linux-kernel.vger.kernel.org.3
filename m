Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514B573D12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiGMTUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGMTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:20:03 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F1721818;
        Wed, 13 Jul 2022 12:20:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9E9E242685E;
        Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kKbS3WRHe1BQ; Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 112C0426C13;
        Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 112C0426C13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1657740000;
        bh=RMWgUjxlJ5h9ifad36+paV2jGXpFbQkk5sUyLZfsdlU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EARasB/73KXy5eMCnFCiftad+GY4PfT9vwRYEREFi4KXWiDE0Pa5mTT8LNfVjS2cV
         aiYjyjO4EfYYiJh3JhkpbEfbHGDHeGYMaLWFM1cGYPp7ggL4rHOR/vnFsZEQCXCpnj
         41DCR8a6bV6YiAU7NgQSsiqQRRnJZqzH0Mfxu/Nq2Hgmk/TS3NE9ZhFPJnnInRjH/l
         0aq0BaYpqf91Ko8fKoJb3/XJ4r53Fg1KUcGgtlc0FW0b9iDi80k2C5i5haygpt71Fk
         3KFZnBttk7V5Zvmc7Cj7jEiT4ha8WdFFBCfaHffiwaXa7vFGpHCosb5KvSbBbwDLP9
         G/4i3WZQt2r2w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LbT8Uuda7r0a; Wed, 13 Jul 2022 15:20:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DBA664268F3;
        Wed, 13 Jul 2022 15:19:59 -0400 (EDT)
Date:   Wed, 13 Jul 2022 15:19:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        linuxtools-dev@eclipse.org, lttng-dev <lttng-dev@lists.lttng.org>,
        lwn <lwn@lwn.net>,
        Trace Compass Developer Discussions 
        <tracecompass-dev@eclipse.org>
Message-ID: <1084656607.67311.1657739999848.JavaMail.zimbra@efficios.com>
Subject: Tracing Summit 2022: Announcement and Call for Proposals, October
 11th - 13th, 2022, London, United Kingdom
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Index: GhFp6sgYm5dGm85QpgTZYdYT1/wVUg==
Thread-Topic: Tracing Summit 2022: Announcement and Call for Proposals, October 11th - 13th, 2022, London, United Kingdom
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_GREY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a Call for Proposals for the Tracing Summit 2022[0] which will be held in London, United Kingdom on 11th to 13th of October, 2022.

- Location: Google, 6 Pancras Sq, London N1C 4AG, UK
- Event dates: Tuesday the 11th to Thursday the 13th of October, 2022
- Cost: Free
- CFP link: [1]
- Register to attend: [2]

Timeline:

- CFP Opens: July 13th, 2022
- Registration opens: July 13th, 2022
- CFP Closes: September 1st, 2022
- Registration closes: October 3rd, 2022

You can subscribe to the mailing list to get the latest information on the event: [3]

The Tracing Summit is a three-day, single-track conference on the topic of tracing. The event focuses on software and hardware tracing, gathering developers and end-users of tracing and trace analysis tools. The main goal of the Tracing Summit is to provide space for discussion between people of the various areas that benefit from tracing, namely parallel, distributed and/or real-time systems, as well as kernel development.

We are welcoming 30 minute presentations on topics covering, but not limited to:

- Investigation workflow of real-time, latency, and throughput issues,
- Trace collection and extraction,
- Trace filtering,
- Trace aggregation,
- Trace formats,
- Tracing multi-core systems,
- Trace abstraction,
- Trace modeling,
- Automated trace analysis (e.g. dependency analysis),
- Tracing large clusters and distributed systems,
- Hardware-level tracing (e.g. DSP, GPU, bare-metal),
- Trace visualization,
- Interaction between debugging and tracing,
- Tracing remote control,
- Analysis of large trace datasets,
- Cloud trace collection and analysis,
- Integration between trace tools,
- Live tracing & monitoring,
- Programmable tracing (e.g. eBPF).

Those can cover available technologies, ongoing work, and yet non-existent technologies (which are compelling to end-users).
Please understand that this open forum is not the proper place to present sales or marketing pitches, nor technologies which are prevented from being freely used in open source.

This year tickets are free and seating is limited to 80 people.

To register use the following link: [2]

Please send any queries about this conference to info@tracingsummit.org .

[0]: https://tracingsummit.org
[1]: https://docs.google.com/forms/d/e/1FAIpQLSf65-LaD5EiYSxSN6D6XGRazExSur0SW7oG6ZIpGpDN4ra_rg/viewform
[2]: https://docs.google.com/forms/d/e/1FAIpQLSdq4whieesZeoHJq1h2CDbWeO5FuQnPk6G257hfSLgnWRenvg/viewform
[3]: http://eepurl.com/goakfv

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
