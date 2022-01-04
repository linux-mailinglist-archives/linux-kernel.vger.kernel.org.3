Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E305548399C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 02:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiADBFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 20:05:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:47483 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231531AbiADBFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641258320; x=1672794320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8dyO2f5KlZJZ7TA9fEAzJAHaPEYgAklhoDjBu4l+F0Q=;
  b=bA25kS5fIBUAmp9Oz5+u44zjeM7Yo+hHzT+ilWOKTHBpcQTvSnmYZ1nm
   2ZQvIoKtsmqeepuhBpU/iS0Ryv2vNx9ZNJ4jDTOib8qlbHJd8KKFdxrKr
   sPjeAdI6sNWBqeldL2YpNZYF/j6CM1ShwcS6SRHp2H6HH1cGmTCkPK9rC
   0hvwz81I+zKsraTKZWKI4MesajvsrOVZGZG5EyzGGyutyYKk99Na/vvC5
   XeJDdMXmbxMR/GbpyWy+QSoMiEWThZZ/klVkmf9uWr9bVGr8CHFBeqdd2
   DJZEaxSY0Fr17o9VWn0WK67/jqFKxtfvoX7TavIx7jPtA+Bn7tkBqULXH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="302889089"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="302889089"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 17:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="512264695"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Jan 2022 17:05:19 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4YGM-000EXN-E7; Tue, 04 Jan 2022 01:05:18 +0000
Date:   Tue, 4 Jan 2022 09:04:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [narmstrong-oxnas:oxnas/v5.10/sata 3/3]
 drivers/ata/sata_ox810se.c:1884:34: warning: format '%u' expects a matching
 'unsigned int' argument
Message-ID: <202201040830.seIfdNbp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git oxnas/v5.10/sata
head:   acba9b2498a048f1a89fdac6f661ec263e369e76
commit: acba9b2498a048f1a89fdac6f661ec263e369e76 [3/3] fixup! ata: Add Oxford Semiconductor OX810SE SATA Controller Support
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220104/202201040830.seIfdNbp-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git/commit/?id=acba9b2498a048f1a89fdac6f661ec263e369e76
        git remote add narmstrong-oxnas https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
        git fetch --no-tags narmstrong-oxnas oxnas/v5.10/sata
        git checkout acba9b2498a048f1a89fdac6f661ec263e369e76
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/ata/sata_ox810se.c:408:27: warning: initialized field overwritten [-Woverride-init]
     408 |     .can_queue          = SATA_OXNAS_QUEUE_DEPTH,
         |                           ^~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:408:27: note: (near initialization for 'ox810sata_sht.can_queue')
   drivers/ata/sata_ox810se.c: In function 'ox810sata_driver_probe':
   drivers/ata/sata_ox810se.c:1225:23: warning: unused variable 'gpio_power' [-Wunused-variable]
    1225 |     struct gpio_desc *gpio_power[SATA_OXNAS_MAX_PORTS];
         |                       ^~~~~~~~~~
   In file included from drivers/ata/sata_ox810se.c:33:
   drivers/ata/sata_ox810se.c: In function 'ox810sata_irq_handler':
>> drivers/ata/sata_ox810se.c:1884:34: warning: format '%u' expects a matching 'unsigned int' argument [-Wformat=]
    1884 |                 ata_port_err(ap, "irq#%u INT_REG_ACCESS_ERR\n");
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/libata.h:1479:39: note: in definition of macro 'ata_port_err'
    1479 |         ata_port_printk(ap, KERN_ERR, fmt, ##__VA_ARGS__)
         |                                       ^~~
   drivers/ata/sata_ox810se.c:1884:40: note: format string is defined here
    1884 |                 ata_port_err(ap, "irq#%u INT_REG_ACCESS_ERR\n");
         |                                       ~^
         |                                        |
         |                                        unsigned int
   drivers/ata/sata_ox810se.c:1886:80: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    1886 |                 VPRINTKI("irq#%d status=0x%08X cnr=%d\n", irq, int_status, cnr);
         |                                                                                ^
   drivers/ata/sata_ox810se.c: In function 'ox810sata_port_stop':
   drivers/ata/sata_ox810se.c:1954:28: warning: unused variable 'pd' [-Wunused-variable]
    1954 |     ox810sata_port_priv_t *pd = NULLPTR(ap) ? NULL : ap->private_data;
         |                            ^~
   drivers/ata/sata_ox810se.c: At top level:
>> drivers/ata/sata_ox810se.c:2044:6: warning: no previous prototype for 'oxnassata_RAID_faults' [-Wmissing-prototypes]
    2044 | int  oxnassata_RAID_faults(void) {
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/sata_ox810se.c:2057:5: warning: no previous prototype for 'oxnassata_get_port_no' [-Wmissing-prototypes]
    2057 | int oxnassata_get_port_no(struct request_queue *q)
         |     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/sata_ox810se.c:2093:5: warning: no previous prototype for 'oxnassata_LBA_schemes_compatible' [-Wmissing-prototypes]
    2093 | int oxnassata_LBA_schemes_compatible(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/sata_ox810se.c:493:13: warning: 'ox810sata_clock_disable' defined but not used [-Wunused-function]
     493 | static void ox810sata_clock_disable(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +1884 drivers/ata/sata_ox810se.c

  1852	
  1853	/** 
  1854	 * irq_handler is the interrupt handling routine registered with the system,
  1855	 * by libata.
  1856	 */
  1857	static irqreturn_t ox810sata_irq_handler(int irq, void *dev_instance)
  1858	{
  1859	    int cnr, port_no;
  1860	    irqreturn_t ret = IRQ_NONE;
  1861	
  1862	    for (port_no = 0; port_no < SATA_OXNAS_MAX_PORTS; port_no++) {
  1863	        u32 int_status = 0;
  1864	        struct ata_port *ap = ((struct ata_host *)dev_instance)->ports[port_no];
  1865	        if (NULLPTR(ap))
  1866	            continue;
  1867	
  1868	        // check the ISR for the port to see if it created the interrupt
  1869	        cnr = 0;
  1870	        while (cnr < 3) {
  1871	            u32 i = ox810sata_ioportraid_read(ap, INT_STATUS) & INT_USED;
  1872	            if (!i)
  1873	                break;
  1874	            // Clear and mask pending interrupts
  1875	            ox810sata_ioportraid_andor(ap, INT_CLEAR, 0, i);
  1876	            ox810sata_ioportraid_andor(ap, INT_DISABLE, 0, i);
  1877	            // store interrupt status for the bottom end
  1878	            int_status |= i;
  1879	            cnr++;
  1880	        };
  1881	
  1882	        if (cnr) {
  1883	            if (int_status & INT_REG_ACCESS_ERR)
> 1884	                ata_port_err(ap, "irq#%u INT_REG_ACCESS_ERR\n");
  1885	            else
> 1886	                VPRINTKI("irq#%d status=0x%08X cnr=%d\n", irq, int_status, cnr);
  1887	
  1888	            if (!ox810sata_dma_busy_check(ap)) {
  1889	                if (int_status & INT_END_OF_CMD)
  1890	                    ox810sata_qc_complete(ap, AC_ERR_OK);
  1891	            }
  1892	
  1893	            if (int_status & (INT_LINK_SERROR | INT_LINK_IRQ)) {
  1894	                u32 serror = ox810sata_scr_read_port(ap, SCR_ERROR);
  1895	                if(serror & (SERR_DEV_XCHG | SERR_PHYRDY_CHG)) {
  1896	                    ata_port_info(ap, "hotplug event\n");
  1897	                    ap->link.eh_info.action |= ATA_EH_RESET;
  1898	                    ata_ehi_hotplugged(&ap->link.eh_info);
  1899	                    ata_port_freeze(ap);
  1900	//                    ox810sata_irq_on(ap);
  1901	                }
  1902	            }
  1903	
  1904	            ret = IRQ_HANDLED;
  1905	//            return ret;
  1906	        }
  1907	    }
  1908	
  1909	    return ret;
  1910	}
  1911	
  1912	/** 
  1913	 * port_start() is called just after the data structures for each port are
  1914	 * initialized. Typically this is used to alloc per-port DMA buffers, tables
  1915	 * rings, enable DMA engines and similar tasks.
  1916	 *
  1917	 * @return 0 = success
  1918	 * @param ap hardware with the registers in
  1919	 */
  1920	static int ox810sata_port_start(struct ata_port *ap)
  1921	{
  1922	    ox810sata_port_priv_t *pd;
  1923	    int rc;
  1924	
  1925	    rc = ata_bmdma_port_start(ap);
  1926	    if (rc)
  1927	        return rc;
  1928	
  1929	    /* allocate port private data memory and attach to port */
  1930	    pd = devm_kzalloc(&ox810sata_hd.pdev->dev, sizeof(ox810sata_port_priv_t), GFP_KERNEL);
  1931	    if (NULLPTR(pd))
  1932	        return -ENOMEM;
  1933	    ap->private_data = pd;
  1934	    ap->print_id = ap->port_no + 1;
  1935	    pd->port = ap;
  1936	    pd->scrlock = __SPIN_LOCK_UNLOCKED(pd->scrlock);
  1937	
  1938	    ata_port_info(ap, "port%u started\n", ap->port_no);
  1939	
  1940	    // Additional cleanup/reset(s) to workaround for
  1941	    // core not responding when issuing first queued command
  1942	    (void)ox810sata_cleanup(ap);
  1943	
  1944	    return 0;
  1945	}
  1946	
  1947	/** 
  1948	 * port_stop() is called after ->host_stop(). It's sole function is to 
  1949	 * release DMA/memory resources, now that they are no longer actively being
  1950	 * used.
  1951	 */
  1952	static void ox810sata_port_stop(struct ata_port *ap)
  1953	{
> 1954	    ox810sata_port_priv_t *pd = NULLPTR(ap) ? NULL : ap->private_data;
  1955	
  1956	    VPRINTKI("\n");
  1957	
  1958	    ox810sata_qc_complete(ap, AC_ERR_OK);
  1959	    (void)ox810sata_cleanup(ap);
  1960	    ox810sata_irq_off(ap);
  1961	}
  1962	
  1963	
  1964	static void ox810sata_error_handler(struct ata_port *ap)
  1965	{
  1966	    VPRINTKI("\n");
  1967	
  1968	//    if (ox810sata_core_busy_check())
  1969	        (void)ox810sata_cleanup(ap);
  1970	
  1971	    ata_std_error_handler(ap);
  1972	}
  1973	
  1974	
  1975	
  1976	static void ox810sata_post_internal_cmd(struct ata_queued_cmd *qc)
  1977	{
  1978	    VPRINTKI("ata%u: tag#%u\n", qc->ap->print_id, qc->tag);
  1979	
  1980	    if (qc->flags & ATA_QCFLAG_FAILED) {
  1981	         /* If the core is busy here, make it idle */
  1982	//        if (ox810sata_core_busy_check())
  1983	//            if (ata_is_pio(qc->tf.protocol))
  1984	                ox810sata_cleanup(qc->ap);
  1985	    }
  1986	}
  1987	
  1988	
  1989	static int ox810sata_check_ready(struct ata_link *link)
  1990	{
  1991	    u8 status = ox810sata_check_status(link->ap);
  1992	
  1993	    return ata_check_ready(status);
  1994	}
  1995	
  1996	static int ox810sata_softreset(struct ata_link *link, unsigned int *class, unsigned long deadline)
  1997	{
  1998	    int rc;
  1999	    struct ata_port *ap = link->ap;
  2000	    struct ata_taskfile tf;
  2001	
  2002	    VPRINTKI("\n");
  2003	
  2004	    if (ata_link_offline(link)) {
  2005	        DPRINTKW("PHY reports no device\n");
  2006	        if (!NULLPTR(class))
  2007	            *class = ATA_DEV_NONE;
  2008	        return 0;
  2009	    }
  2010	
  2011	    ox810sata_srst_send(ap);
  2012	
  2013	    rc = ata_wait_ready(link, deadline, ox810sata_check_ready);
  2014	
  2015	    // if link is occupied, -ENODEV too is an error
  2016	    if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
  2017	        ata_port_err(ap, "SRST failed (errno=%d)\n", rc);
  2018	        return rc;
  2019	    }
  2020	
  2021	    // determine by signature whether we have ATA or ATAPI devices
  2022	    ox810sata_tf_read(ap, &tf);
  2023	    if (!NULLPTR(class)) {
  2024	        *class = ata_dev_classify(&tf);
  2025	
  2026	        if (*class == ATA_DEV_UNKNOWN)
  2027	            *class = ATA_DEV_NONE;
  2028	
  2029	        VPRINTKI("class=%u\n", *class);
  2030	    }
  2031	
  2032	    return 0;
  2033	}
  2034	
  2035	
  2036	/**************************************************************************
  2037	* Linux HW-RAID support
  2038	**************************************************************************/
  2039	
  2040	/**
  2041	 * Returns accumulated RAID faults and then clears the accumulation
  2042	 * @return accumulated RAID faults indicated by set bits
  2043	 */
> 2044	int  oxnassata_RAID_faults(void) {
  2045	    int temp = ox810sata_accumulated_RAID_faults;
  2046	    ox810sata_accumulated_RAID_faults = 0;
  2047	    return temp;
  2048	}
  2049	EXPORT_SYMBOL(oxnassata_RAID_faults);
  2050	
  2051	/**
  2052	 * Returns ox810 port number the request queue is serviced by.
  2053	 *
  2054	 * @param queue The queue under investigation.
  2055	 * @return The ox810 sata port number servicing the queue or -1 if not found.
  2056	 */
> 2057	int oxnassata_get_port_no(struct request_queue *q)
  2058	{
  2059	    struct ata_port *ap = 0;
  2060	    struct scsi_device *sdev = 0;
  2061	
  2062	    /* check port 0 */
  2063	    ap = ox810sata_hd.host->n_ports > 0
  2064	        ? ox810sata_hd.host->ports[0] : NULL;
  2065	    if (ap)
  2066	        shost_for_each_device(sdev, ap->scsi_host) {
  2067	            if (sdev->request_queue == q) {
  2068	                DPRINTK("queue %p on port 0\n", q);
  2069	                return 0;
  2070	            }
  2071	        }
  2072	    
  2073	    /* check port 1 */
  2074	    ap = ox810sata_hd.host->n_ports > 1
  2075	        ? ox810sata_hd.host->ports[1] : NULL;
  2076	    if (ap)
  2077	        shost_for_each_device(sdev, ap->scsi_host) {
  2078	            if (sdev->request_queue == q) {
  2079	                DPRINTK("queue %p on port 1\n", q);
  2080	                return 1;
  2081	            }
  2082	        }
  2083	
  2084	    /* not found */
  2085	    return -1;  
  2086	}
  2087	EXPORT_SYMBOL(oxnassata_get_port_no);
  2088	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
